Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287863AbSBEEYq>; Mon, 4 Feb 2002 23:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288019AbSBEEY1>; Mon, 4 Feb 2002 23:24:27 -0500
Received: from dsl092-237-176.phl1.dsl.speakeasy.net ([66.92.237.176]:15890
	"EHLO whisper.qrpff.net") by vger.kernel.org with ESMTP
	id <S287863AbSBEEYY>; Mon, 4 Feb 2002 23:24:24 -0500
Message-Id: <5.1.0.14.2.20020204230409.00a886b0@whisper.qrpff.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 04 Feb 2002 23:04:50 -0500
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
From: Stevie O <stevie@qrpff.net>
Subject: Re: Asynchronous CDROM Events in Userland
In-Reply-To: <a3l4uc$laf$1@cesium.transmeta.com>
In-Reply-To: <Pine.LNX.4.30.0202032333200.1158-100000@rtlab.med.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:07 PM 2/3/2002 -0800, H. Peter Anvin wrote:
>Rather than a signal, it should be a file descriptor of some sort, so
>one can select() etc on it.  Personally I can't imagine polling would
>take any appreciable amount of resources, though.

Windows 95 polls the cd-rom drive for autorun.

It kills laptop batteries REAL quick.

CPU & memory aren't the only resources...


--
Stevie-O

Real programmers use COPY CON PROGRAM.EXE

