Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282329AbRKZTI5>; Mon, 26 Nov 2001 14:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282050AbRKZTHF>; Mon, 26 Nov 2001 14:07:05 -0500
Received: from mail.coastside.net ([207.213.212.6]:64197 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S282381AbRKZTGK>; Mon, 26 Nov 2001 14:06:10 -0500
Mime-Version: 1.0
Message-Id: <p05100307b82842b5492a@[207.213.214.37]>
In-Reply-To: <Pine.LNX.4.21.0111261524560.13976-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0111261524560.13976-100000@freak.distro.conectiva>
Date: Mon, 26 Nov 2001 11:06:04 -0800
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Release Policy [was: Linux 2.4.16  ]
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:25 PM -0200 11/26/01, Marcelo Tosatti wrote:
>  > Consistency is a Very Good Thing[TM] (says the one who tries to teach
>>  scripts to understand the naming.)  The advantage with the -rc naming is
>>  that it avoids the -pre5, -pre6, -pre-final, -pre-final-really,
>>  -pre-final-really-i-mean-it-this-time phenomenon when the release
>>  candidate wasn't quite worthy, you just go -rc1, -rc2, -rc3.  There is no
>>  shame in needing more than one release candidate.
>
>Agreed. I stick with the -rc naming convention for 2.4+...

A quibble: "release" seems an odd word to choose for a Linux kernel. 
Since we're calling the target kernel "final", how about -fc1, 
-fc2...?
-- 
/Jonathan Lundell.
