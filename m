Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275482AbRJFSku>; Sat, 6 Oct 2001 14:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275486AbRJFSkl>; Sat, 6 Oct 2001 14:40:41 -0400
Received: from dfw-smtpout4.email.verio.net ([129.250.36.44]:3039 "EHLO
	dfw-smtpout4.email.verio.net") by vger.kernel.org with ESMTP
	id <S275482AbRJFSka>; Sat, 6 Oct 2001 14:40:30 -0400
Message-ID: <3BBF5036.8DC8C240@bigfoot.com>
Date: Sat, 06 Oct 2001 11:40:54 -0700
From: Tim Moore <timothymoore@bigfoot.com>
Organization: Yoyodyne Propulsion Systems, Inc.
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.20p10i i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anthony <aslan@ispdr.net.au>
CC: linux-kernel@vger.kernel.org
Subject: Re: HDD boot parameters
In-Reply-To: <4.3.2.7.2.20011006235620.00b522b0@mail.ispdr.net.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi again everyone. I'll make this real quick. Can anyone tell me what the
> lilo parameter is to re-map the CHS geometry of hdc? Thanx in advance!
> 
> ----------------------------
> Anthony (aslan@ispdr.net.au)
> ----------------------------

/usr/src/linux/Documentation/ide.txt

append="hda=1027,255,63"
--
