Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261751AbSJIOYC>; Wed, 9 Oct 2002 10:24:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261765AbSJIOYC>; Wed, 9 Oct 2002 10:24:02 -0400
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:62881 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261751AbSJIOYA>; Wed, 9 Oct 2002 10:24:00 -0400
Subject: Re: softdog doesn't work on 2.4.20-pre10?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200210091607.32769.roy@karlsbakk.net>
References: <200210091607.32769.roy@karlsbakk.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 09 Oct 2002 15:40:09 +0100
Message-Id: <1034174409.1970.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-09 at 15:07, Roy Sigurd Karlsbakk wrote:
> hi
> 
> I have the softdog running on some of my machines, and I noticed it didn't 
> work very well. I've got this little program feeding the dog (attached), so 
> if it gets killed, the machine should reboot.

Make sure you have no way out set

