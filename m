Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbRDYNH3>; Wed, 25 Apr 2001 09:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135737AbRDYNHU>; Wed, 25 Apr 2001 09:07:20 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:17931 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S133009AbRDYNHI>;
	Wed, 25 Apr 2001 09:07:08 -0400
Date: Wed, 25 Apr 2001 06:07:52 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: imel96@trustix.co.id
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Single user linux
In-Reply-To: <20010425120319Z135634-682+3531@vger.kernel.org>
Message-ID: <Pine.LNX.4.10.10104250552460.9854-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2001 imel96@trustix.co.id wrote:

[snip]
> so i guess i deserve opinions instead of flames. the
> approach is from personal use, not the usual server use.
> if you think a server setup is best for all use just say so,
> i'm listening.
> 

Heres one.. most of the time I spend cleaning up windows machines is not
because of software problems.  Usually it's the user acidentally erasing
something or installing some program that just modified the boot files by
accident.

Protection makes the system easier not harder.  You can add SUID
aplications to preform administrative tasks such as upgrading / config and
be sure that the user won't accidentally erase the system.  

I've had users absolutely paranoid of breaking something on my systems
it's very reasuring for me to be able to point at the power switch and say
"see that? don't touch it and the sustem will be fine"

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

