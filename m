Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316598AbSEUVKx>; Tue, 21 May 2002 17:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316600AbSEUVKw>; Tue, 21 May 2002 17:10:52 -0400
Received: from numenor.qualcomm.com ([129.46.51.58]:36326 "EHLO
	numenor.qualcomm.com") by vger.kernel.org with ESMTP
	id <S316598AbSEUVKw>; Tue, 21 May 2002 17:10:52 -0400
Message-Id: <5.1.0.14.2.20020521134410.06934b70@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 21 May 2002 14:09:15 -0700
To: Johannes Erdfelt <johannes@erdfelt.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [linux-usb-devel] RE: What to do with all of the USB UHCI
  drivers in the kernel ?
Cc: greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net
In-Reply-To: <20020521160012.D2645@sventech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Please test the latest version of the drivers. Both uhci and usb-uhci
>have had various bug fixes. I'm sure the performance problems you've had
>with uhci have been fixed for a little while now.
Yep. I did a quick test with Intel, Ericsson and Broadcom devices.
Both HCDs have the same performance in 2.4.19-pre8.

>Also, feedback about the -hcd variants would useful too since one of
>those will be the only ones left for 2.5.
Will do.

Max

