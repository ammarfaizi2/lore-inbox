Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264431AbTICUUu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 16:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264406AbTICUTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 16:19:11 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:44810 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264399AbTICUSC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 16:18:02 -0400
Date: Wed, 3 Sep 2003 21:18:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Clark <jimwclark@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Driver Model 2 Proposal - Linux Kernel Performance v Usability
Message-ID: <20030903211801.A10695@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Clark <jimwclark@ntlworld.com>, linux-kernel@vger.kernel.org
References: <200309031850.14925.jimwclark@ntlworld.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200309031850.14925.jimwclark@ntlworld.com>; from jimwclark@ntlworld.com on Wed, Sep 03, 2003 at 06:53:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 03, 2003 at 06:53:01PM +0100, James Clark wrote:
> Following my initial post yesterday please find attached my proposal for a 
> binary 'plugin' interface:
> 
> This is not an attempt to have a Microkernel, or any move away from GNU/OSS 
> software. I believe that sometimes the ultimate goals of stability and 
> portability get lost in the debate on OSS and desire to allow anyone to 
> contribute. It is worth remembering that for every Kernel hacker there must 
> be 1000's of plain users. I believe this proposal would lead to better 
> software and more people using it.

Looks like you're looking for UDI.  Most people on this list don't like
it for various reasons (me included) but you seem to like it.  Since
SCO was the driving factor development probably has slowed down even
more, go and help them!

Don't expect it to ever be merged though..

	http://projectudi.sourceforge.net/
