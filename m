Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279557AbRKASyw>; Thu, 1 Nov 2001 13:54:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279574AbRKASym>; Thu, 1 Nov 2001 13:54:42 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:18191 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S279557AbRKASyi>;
	Thu, 1 Nov 2001 13:54:38 -0500
Date: Thu, 1 Nov 2001 10:52:28 -0800
From: Greg KH <greg@kroah.com>
To: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
Cc: linux-kernel@vger.kernel.org, derick@jdimedia.nl
Subject: Re: USB oops
Message-ID: <20011101105228.B544@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0111011310080.27910-100000@jdi.jdimedia.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0111011310080.27910-100000@jdi.jdimedia.nl>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.19 (i586)
Reply-By: Thu, 04 Oct 2001 17:38:57 -0700
X-Message-Flag: Message text blocked: Unsuitable for Adults
X-Message: This could be an Outlook virus! Are you sure you want to continue using Outlook?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 01:17:51PM +0100, Igmar Palsenberg wrote:
> 
> Hi,
> 
> insmodding USB stuff oopsed 2.4.13
> OOPS and lspci -vv output below.

Can you try the -ac tree?  It should have a fix for this problem.

thanks,

greg k-h
