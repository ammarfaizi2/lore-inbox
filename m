Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319115AbSHFNZE>; Tue, 6 Aug 2002 09:25:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318917AbSHFNZE>; Tue, 6 Aug 2002 09:25:04 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:58873 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S319115AbSHFNZD>; Tue, 6 Aug 2002 09:25:03 -0400
Subject: Re: i810 sound broken...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: venom@sns.it, Thomas Munck Steenholdt <tmus@get2net.dk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m31y9dt29p.fsf@lapper.ihatent.com>
References: <Pine.LNX.4.43.0208051546120.8463-100000@cibs9.sns.it>
	<1028561325.18478.55.camel@irongate.swansea.linux.org.uk> 
	<m31y9dt29p.fsf@lapper.ihatent.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Aug 2002 15:47:33 +0100
Message-Id: <1028645253.18130.164.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-05 at 22:38, Alexander Hoogerhuis wrote:
> 
> Different thing about 810, brand spanking new Compaq
> Game^H^H^H^Hlaptop and it gives good sound, but shows this on boot:
> 
> i810: Intel ICH3 found at IO 0x4400 and 0x4000, IRQ 5
> i810_audio: Audio Controller supports 6 channels.
> ac97_codec: AC97 Audio codec, id: 0x4144:0x5363 (Unknown)
> i810_audio: AC'97 codec 0 Unable to map surround DAC's (or DAC's \
> not present), total channels = 2

Thats fine. Your chipset supports 6 channel surround sound. Your vendor
didn't feel the need to fit codecs for anything more than stereo

