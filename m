Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135593AbRD2AMU>; Sat, 28 Apr 2001 20:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135602AbRD2AMK>; Sat, 28 Apr 2001 20:12:10 -0400
Received: from 513.holly-springs.nc.us ([216.27.31.173]:58914 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S135593AbRD2AMB>; Sat, 28 Apr 2001 20:12:01 -0400
Message-ID: <030d01c0d05a$269c5eb0$8501a8c0@gromit>
From: "Michael Rothwell" <rothwell@holly-springs.nc.us>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200104282236.AAA06021@cave.bitwizard.nl> <9cflov$fdv$1@cesium.transmeta.com>
Subject: Re: Sony Memory stick format funnies...
Date: Sat, 28 Apr 2001 20:11:57 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "H. Peter Anvin" <hpa@zytor.com>
> "dcim" probably stands for "digital camera images".  At least Canon
> digital cameras always put their data in a directory named dcim.

Makes sense. FAT's root directory is limited in the number of entries it can
contain, to something like 32. Cameras can easily produce more than that
number of images.

-M


