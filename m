Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267039AbTBLLga>; Wed, 12 Feb 2003 06:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267042AbTBLLga>; Wed, 12 Feb 2003 06:36:30 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:63500 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267039AbTBLLg3>; Wed, 12 Feb 2003 06:36:29 -0500
Date: Wed, 12 Feb 2003 11:46:17 +0000
From: Christoph Hellwig <hch@infradead.org>
To: LA Walsh <law@tlinx.org>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: lsm truly "generic" allowing complete choice?  Clean? Simple?  I don't think so.
Message-ID: <20030212114617.A4648@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	LA Walsh <law@tlinx.org>, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <200302120142.34882.russell@coker.com.au> <000201c2d266$4daa51a0$1403a8c0@sc.tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <000201c2d266$4daa51a0$1403a8c0@sc.tlinx.org>; from law@tlinx.org on Tue, Feb 11, 2003 at 11:13:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2003 at 11:13:55PM -0800, LA Walsh wrote:
> > -----Original Message-----
> > From: Russell Coker
> > 
> > I think that most people who want to use LSM and similar 
> > systems don't want to 
> > re-write any significant portion of their applications.  
> ---
> 	I would agree -- that is true for _most_ people.

This is eactly the wrong attitude.  You need to carefull design an audit
all application for a secure system.

> 	Maybe I'd be able to configure out paging support as well..

That's CONFIG_SWAP in Linux 2.5..

