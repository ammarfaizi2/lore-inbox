Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314958AbSDWAU5>; Mon, 22 Apr 2002 20:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314971AbSDWAU4>; Mon, 22 Apr 2002 20:20:56 -0400
Received: from mailc.telia.com ([194.22.190.4]:53239 "EHLO mailc.telia.com")
	by vger.kernel.org with ESMTP id <S314958AbSDWAUz>;
	Mon, 22 Apr 2002 20:20:55 -0400
Message-ID: <3CC4A8D3.7060807@dark-past.mine.nu>
Date: Tue, 23 Apr 2002 02:20:35 +0200
From: Peter Andersson <peter@dark-past.mine.nu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: flush_cache when trying to compile agp support on linux ppc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I hope you have not heard this before (but i am sure you have). I am 
trying to compile linux kernel 2.4.18 for suse linux ppc 7.1 and when i 
get to "agpgart_be.c" i get the message "#error "Please define 
flush_cache.". Does anyone know how to solve this? I have tried 
searching the internet and of course your mailing lists but came up with 
nothing.

Please help me out with this one

Peter



