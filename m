Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262406AbTCROXn>; Tue, 18 Mar 2003 09:23:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262410AbTCROXn>; Tue, 18 Mar 2003 09:23:43 -0500
Received: from f125.pav2.hotmail.com ([64.4.37.125]:61966 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S262406AbTCROXm>;
	Tue, 18 Mar 2003 09:23:42 -0500
X-Originating-IP: [211.28.96.71]
From: "dean ." <ioooioiiooi@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ALSA + mmap or OSS emulation + mmap producing stutering sound
Date: Tue, 18 Mar 2003 14:34:33 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F125yXde2kqkOzV8Q3i00001772@hotmail.com>
X-OriginalArrivalTime: 18 Mar 2003 14:34:33.0274 (UTC) FILETIME=[7E1271A0:01C2ED5B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>This is due to a broken ALSA update patch for the cs46xx code.  Apply
>>>the included patch which unbreaks the update.
>>>
>>>David
>>>
>
>>>dean . wrote:
>
>This does not seem to be the case. The problems described below are
>replicable in 2.5.64-mm8 which has the suggested patch applied.
>
>Luuk
>
>
>
>
>>Kernel versions 2.5.61-64 (Havnt tried 60) produce stuttering sound
>>when using alsa and mmap (xmms alsa output plugin) or oss emu and mmap
>>(quake3?) produce stuttering sound happening after around the first
>>half second of playing. This is with the kernels alsa cs46xx module
>>and a Turtle beach Santa Cruz soundcard. Works fine with 2.5.59 though.

I had the same result here, the patch didnt help the stuttering

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail

