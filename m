Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268712AbRHGP23>; Tue, 7 Aug 2001 11:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268934AbRHGP2T>; Tue, 7 Aug 2001 11:28:19 -0400
Received: from [24.254.60.42] ([24.254.60.42]:14560 "EHLO
	femail48.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S268838AbRHGP2H>; Tue, 7 Aug 2001 11:28:07 -0400
Date: Tue, 7 Aug 2001 11:30:25 -0400 (EDT)
From: Garett Spencley <gspen@home.com>
X-X-Sender: <gspen@localhost.localdomain>
To: David Maynor <david.maynor@oit.gatech.edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap
In-Reply-To: <5.1.0.14.2.20010807110412.00a8bec0@pop.prism.gatech.edu>
Message-ID: <Pine.LNX.4.33L2.0108071128530.16003-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, David Maynor wrote:

> But is the 10% perf hit really gaining you anything, expect to quell your
> paranoia. What is next, an encrypted /proc so that possible attackers can't
> gain information about running processes?
>
> David Maynor

Actually the openwall (http://www.openwall.com/linux) security patches do
something similar to this. I'm not actually sure if they encrypt it or
they just prevent read access to it by normal users but the effect is
the same. It can be a desirable security feature.

-- 
Garett Spencley

I encourage you to encrypt e-mail sent to me using PGP
My public key is available on PGP key servers (http://keyservers.net)
Key fingerprint: 8062 1A46 9719 C929 578C BB4E 7799 EC1A AB12 D3B9

