Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318149AbSGMMSg>; Sat, 13 Jul 2002 08:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318150AbSGMMSf>; Sat, 13 Jul 2002 08:18:35 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:25278 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S318149AbSGMMSf>; Sat, 13 Jul 2002 08:18:35 -0400
Date: Sat, 13 Jul 2002 14:38:13 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@linux-box.realnet.co.sz
To: Peter Osterlund <petero2@telia.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.19-rc1-ac3
In-Reply-To: <m2adovvru6.fsf@best.localdomain>
Message-ID: <Pine.LNX.4.44.0207131435570.3808-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jul 2002, Peter Osterlund wrote:

> OK, see data below. Btw, I also noticed that the usage example at
> http://www.brodo.de/cpufreq/ is wrong. It says:
> 
>         root@notebook:# echo -n /proc/sys/cpu/0/speed-max > /proc/sys/cpu/0/speed
> 
> but you need to say:
> 
>         cat /proc/sys/cpu/0/speed-max > /proc/sys/cpu/0/speed

Common thinko. Thanks for the info and patch, did the higher duty cycles 
have the desired effect?

Cheers,
	Zwane

-- 
function.linuxpower.ca

