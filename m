Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314500AbSEYMP3>; Sat, 25 May 2002 08:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314502AbSEYMP2>; Sat, 25 May 2002 08:15:28 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:55281 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314500AbSEYMP2>; Sat, 25 May 2002 08:15:28 -0400
Subject: Re: Nforce chipset and 2.2 kernels
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Hayden James <hjames@stevens-tech.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.30.0205250203400.5168315-100000@attila.stevens-tech.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 25 May 2002 14:16:37 +0100
Message-Id: <1022332597.11811.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-05-25 at 07:13, Hayden James wrote:
> You are shit out of luck, upgrade to 2.4 and deal with the lack of
> free complete drivers for the onboard audio, network, and video or return
> the boards. I am not even sure if 2.4 will work seeing as how I was
> told(by Alan and Vojtech) that 2.5 is the only kernel that supports the IDE
> chipset on the board.

Fixing the IDE to work in the stable tree appears to be just adding some
PCI idents so that bit shouldn't be too problematic. The rest is not
good though

Alan

