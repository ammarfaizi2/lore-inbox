Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262549AbVCJMSq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262549AbVCJMSq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 07:18:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVCJMSq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 07:18:46 -0500
Received: from 62-177-247-250.dyn.bbeyond.nl ([62.177.247.250]:53775 "EHLO
	www.ithos.nl") by vger.kernel.org with ESMTP id S262549AbVCJMS1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 07:18:27 -0500
Date: Thu, 10 Mar 2005 02:33:50 +0100 (CET)
From: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
X-X-Sender: rbultje@www.ithos.nl
To: Jean Delvare <khali@linux-fr.org>
cc: Chris Wright <chrisw@osdl.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Daniel Staaf <dst@bostream.nu>, LKML <linux-kernel@vger.kernel.org>,
       Andrei Mikhailovsky <andrei@arhont.com>,
       Ian Campbell <icampbell@arcom.com>, Gerd Knorr <kraxel@bytesex.org>,
       stable@kernel.org
Subject: Re: [PATCH 2.6] Fix i2c messsage flags in video drivers
In-Reply-To: <cvxT6YRf.1110455408.1808270.khali@localhost>
Message-ID: <Pine.LNX.4.56.0503100232390.24530@www.ithos.nl>
References: <cvxT6YRf.1110455408.1808270.khali@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jean,

On Thu, 10 Mar 2005, Jean Delvare wrote:
> > My experience is not the same as yours, it seems... I cannot explain why,
> > unfortunately. (...)
>
> I can. [..]
> So as long as you don't move to a 2.6.11 kernel, don't even bother
> trying my patches, because you will never hit the code that I am trying
> to fix.

That makes sense. I'll try the >=.11 kernels sometime soon.

Thanks,
Ronald
