Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284965AbRLUSpt>; Fri, 21 Dec 2001 13:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284968AbRLUSpk>; Fri, 21 Dec 2001 13:45:40 -0500
Received: from f134.law4.hotmail.com ([216.33.149.134]:55565 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S284965AbRLUSpf>;
	Fri, 21 Dec 2001 13:45:35 -0500
X-Originating-IP: [205.231.90.227]
From: "victor1 torres" <camel_3@hotmail.com>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: Concerning a driver rewrite (NOT THE KERNEL)
Date: Fri, 21 Dec 2001 18:45:29 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F134DovvQ0Puz63Bma4000031b8@hotmail.com>
X-OriginalArrivalTime: 21 Dec 2001 18:45:30.0015 (UTC) FILETIME=[A9DFCAF0:01C18A4F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan-
(How do you intend the two pieces to interact ?)
I intend for the two pieces to interact with each other since they both have 
access to the DSP. (DSP code will be aviable in late Janurary for the 
Modem).
(If you are also loading the sound driver you are likely to get into a mess
with current 2.4 because the sound code sticks its nose into the codec bus
somewhat further nowdays. )
I understand that the codec sticks its nose into the codec bus but can´t I 
add another (nose) into it also.
You driver also seems to be assuming the sound
driver has initialised the codec bus and codecs.) How could I fix it if the 
sound codec is not initialised so that the modem codec could initialised  
the codec bus and codecs?
Thank you


_________________________________________________________________
MSN Photos is the easiest way to share and print your photos: 
http://photos.msn.com/support/worldwide.aspx

