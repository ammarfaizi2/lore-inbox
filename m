Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267393AbSLRWK5>; Wed, 18 Dec 2002 17:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267389AbSLRWIw>; Wed, 18 Dec 2002 17:08:52 -0500
Received: from twister.ispgateway.de ([62.67.200.3]:62984 "HELO
	twister.ispgateway.de") by vger.kernel.org with SMTP
	id <S267368AbSLRWIm>; Wed, 18 Dec 2002 17:08:42 -0500
Message-ID: <3E00F3B4.7050209@mailsammler.de>
Date: Wed, 18 Dec 2002 23:16:20 +0100
From: Torben Frey <kernel@mailsammler.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Con Kolivas <conman@kolivas.net>
CC: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Horrible drive performance under concurrent i/o jobs (dlh problem?)
References: <1040245847.3e00e457a4d66@kolivas.net>
In-Reply-To: <1040245847.3e00e457a4d66@kolivas.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Con,

thanks for your fast reply. Unfortunately - I cannot patch a vanilla 
2.4.20 kernel using patch -p1. The first hunk fails, the other ones are 
found with offsets or even fuzz. Although I applied the first hunk 
manually, compiling fails.

Do I need the other patches, too? Or a special version of the kernel?

Greetings from Munich,
Torben

