Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290122AbSAQV3K>; Thu, 17 Jan 2002 16:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290098AbSAQV3A>; Thu, 17 Jan 2002 16:29:00 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:20498 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290122AbSAQV2r>; Thu, 17 Jan 2002 16:28:47 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [Etherboot-users] 1G memory limit and Etherboot
Date: 17 Jan 2002 13:28:30 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a27flu$b01$1@cesium.transmeta.com>
In-Reply-To: <A6CFEF730CCE38449F1774A6B5D62B0C0319BB@shockG.archive.alexa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <A6CFEF730CCE38449F1774A6B5D62B0C0319BB@shockG.archive.alexa.com>
By author:    Guolin Cheng <Guolin@alexa.com>
In newsgroup: linux.dev.kernel
> 
> 	1, Where comes the number 0x38000000, which is 896M? ( I enabled
> CONFIG_HIMEM4G in kernel configuration)
> 

See linux/Documentation/i386/boot.txt

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
