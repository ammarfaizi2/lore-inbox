Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136233AbRDVRo5>; Sun, 22 Apr 2001 13:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136234AbRDVRor>; Sun, 22 Apr 2001 13:44:47 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:24332 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S136233AbRDVRok>;
	Sun, 22 Apr 2001 13:44:40 -0400
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.3-ac12
In-Reply-To: <E14rJw2-0005r5-00@the-village.bc.nu> <d366fw29sv.fsf@lxplus015.cern.ch> <3AE31470.A6F82F52@linux-m68k.org>
From: Jes Sorensen <jes@linuxcare.com>
Date: 22 Apr 2001 19:43:57 +0200
In-Reply-To: Roman Zippel's message of "Sun, 22 Apr 2001 19:27:12 +0200"
Message-ID: <d31yqk25k2.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Roman" == Roman Zippel <zippel@linux-m68k.org> writes:

Roman> Hi, Jes Sorensen wrote:

>> In principle you just need 2.7.2.3 for m68k, but someone decided to
>> raise the bar for all architectures by putting a check in a common
>> header file.

Roman> IIRC 2.7.2.3 has problems with labeled initializers for
Roman> structures, which makes 2.7.2.3 unusable for all archs under
Roman> 2.4.

True, so our bar is egcs-1.1.2, but thats still a bit from 2.96+

Jes
