Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313773AbSFTLpG>; Thu, 20 Jun 2002 07:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313867AbSFTLpF>; Thu, 20 Jun 2002 07:45:05 -0400
Received: from mail.spylog.com ([194.67.35.220]:61383 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S313773AbSFTLpE>;
	Thu, 20 Jun 2002 07:45:04 -0400
Date: Thu, 20 Jun 2002 15:44:59 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa3
Message-ID: <20020620114459.GA13532@spylog.ru>
Mail-Followup-To: Andrea Arcangeli <andrea@suse.de>,
	linux-kernel@vger.kernel.org
References: <20020620055933.GA1308@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20020620055933.GA1308@dualathlon.random>
User-Agent: Mutt/1.4i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea Arcangeli,


Kernel 2.4.19pre10aa3 + hidden_arp (from LVS)



...
Intel(R) PRO/100 Fast Ethernet Adapter - Loadable driver, ver 1.8.38
Copyright (c) 2002 Intel Corporation

eth0: Intel(R) 8255x-based Ethernet Adapter
  Mem:0xfb101000  IRQ:18  Speed:100 Mbps  Dx:Full
  Hardware receive checksums enabled
  cpu cycle saver enabled
...

...
eth0 e100_wait_exec_cmd: Wait failed.
hw tcp v4 csum failed
hw tcp v4 csum failed
hw tcp v4 csum failed
hw tcp v4 csum failed
hw tcp v4 csum failed
hw tcp v4 csum failed
hw tcp v4 csum failed
...


Than this message is caused? It something serious also can be problems?


bye.
--
