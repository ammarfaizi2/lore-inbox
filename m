Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290945AbSBFXeS>; Wed, 6 Feb 2002 18:34:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290946AbSBFXeI>; Wed, 6 Feb 2002 18:34:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1040 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S290945AbSBFXd4>; Wed, 6 Feb 2002 18:33:56 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Problems with iso9660 as initrd
Date: 6 Feb 2002 15:33:17 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a3seft$h50$1@cesium.transmeta.com>
In-Reply-To: <m3r8ny8by5.fsf@borg.borderworlds.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <m3r8ny8by5.fsf@borg.borderworlds.dk>
By author:    Christian Laursen <xi@borderworlds.dk>
In newsgroup: linux.dev.kernel
>
> I am building a floppy using a compressed iso9660 filesystem as an
> initrd image.
> 
 [...]
> 
> Am I doing something terribly unusual, or just something wrong here?
> 

You definitely are... I don't think anyone else has ever tried running
a zisofs off a ramdisk before!

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
