Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315591AbSEVPH6>; Wed, 22 May 2002 11:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315595AbSEVPH5>; Wed, 22 May 2002 11:07:57 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:10702 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S315591AbSEVPH4>; Wed, 22 May 2002 11:07:56 -0400
Message-ID: <3CEBB42D.3070807@antefacto.com>
Date: Wed, 22 May 2002 16:07:25 +0100
From: Padraig Brady <padraig@antefacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc2) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.17 /dev/ports
In-Reply-To: <E17AXfM-0001xc-00@the-village.bc.nu> <3CEBA2D4.4080804@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> /proc/cpuinfo for one could be replaced by dropping syslog
> messages at a fixed file in /etc/ during boot - it's static after
> all!.

The new cpufreq dynamic frequency scaling
stuff changes "cpu MHz" and "bogomips" at least.

Padraig.

