Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275695AbRIZXbp>; Wed, 26 Sep 2001 19:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275696AbRIZXbf>; Wed, 26 Sep 2001 19:31:35 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:65037 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S275695AbRIZXbR>;
	Wed, 26 Sep 2001 19:31:17 -0400
Date: Wed, 26 Sep 2001 16:26:58 -0700
From: Greg KH <greg@kroah.com>
To: Crispin Cowan <crispin@wirex.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-security-module@wirex.com,
        linux-kernel@vger.kernel.org
Subject: Re: Binary only module overview
Message-ID: <20010926162658.A20671@kroah.com>
In-Reply-To: <E15lfKE-00047d-00@the-village.bc.nu> <3BB10E8E.10008@wirex.com> <20010925202417.A16558@kroah.com> <3BB229D1.10401@wirex.com> <20010926130156.B19819@kroah.com> <3BB25BA3.1060505@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BB25BA3.1060505@wirex.com>
User-Agent: Mutt/1.3.21i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2001 at 03:50:11PM -0700, Crispin Cowan wrote:
> >a small note in it detailing this disagreement might be a nice thing to do.
> >
> Fair enough.  How about this:
> 
>    "This file is GPL. See the Linux Kernel's COPYING file for details.
>    There is controversy over whether this permits you to write a module
>    that #includes this file without placing your module under the GPL.
>    Consult your lawyer for advice."

That's acceptable to me.  I'll go add that to the tree.

thanks,

greg k-h
