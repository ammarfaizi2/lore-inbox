Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266253AbUAVMAh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 07:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266262AbUAVMAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 07:00:36 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:38664 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266253AbUAVMAf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 07:00:35 -0500
Date: Thu, 22 Jan 2004 12:00:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Dike <jdike@addtoit.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.2-rc1-mm1
Message-ID: <20040122120029.A9758@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040122013501.2251e65e.akpm@osdl.org> <20040122110731.A9319@infradead.org> <200401221217.i0MCHmeS001953@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200401221217.i0MCHmeS001953@ccure.user-mode-linux.org>; from jdike@addtoit.com on Thu, Jan 22, 2004 at 07:17:48AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 22, 2004 at 07:17:48AM -0500, Jeff Dike wrote:
> hch@infradead.org said:
> > And this one brings in perfectly broken 2.4 block drivers.
> 
> Can you be specific?

Try compiling the cow driver.  Or look at the utter devfs mess in ubd.
In fact I wonder why the mail on that devfs abuse that I sent to uml-devel
about half a year ago is still unanswered.

