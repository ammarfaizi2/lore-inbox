Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbUCRNj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 08:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262626AbUCRNj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 08:39:29 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:54282 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262623AbUCRNjZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 08:39:25 -0500
Date: Thu, 18 Mar 2004 13:39:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Remove kernel features (for embedded systems)
Message-ID: <20040318133924.A28744@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Felix von Leitner <felix-kernel@fefe.de>,
	linux-kernel@vger.kernel.org
References: <20040318130640.GA28923@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040318130640.GA28923@codeblau.de>; from felix-kernel@fefe.de on Thu, Mar 18, 2004 at 02:06:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 02:06:40PM +0100, Felix von Leitner wrote:
> I propose to add the following kernel features to the removables:
> 
>   * /dev/kmem and /proc/kcore
>   * core dumping
>   * ptrace
> 
> And if it is at all possible, I would like to be able to remove parts of
> the IP stack, e.g. routing.  In particular, I would like to be able to
> remove policy routing, if it is at all worth it from the code size point
> of view.
> 
> Removing ptrace and kmem is mostly for security reasons, but being able
> to remove them makes sense in embedded environments as well.

Fien with me.  Where are the patches? :)

