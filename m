Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318017AbSIOLYF>; Sun, 15 Sep 2002 07:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318018AbSIOLYF>; Sun, 15 Sep 2002 07:24:05 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:17316 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S318017AbSIOLYF>; Sun, 15 Sep 2002 07:24:05 -0400
Message-ID: <3D846EEC.7070204@myrealbox.com>
Date: Sun, 15 Sep 2002 14:28:44 +0300
From: Andriy Rysin <arysin@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: uk, en-us, ru
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: turning off APIC
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If APIC is compiled in the kernel (wich is the case with most 
distributions) when I start kernel with "noapic" option, APIC is getting 
enabled anyway and only later gets disabled. This causes problems on 
some VAIO notebooks - it seems like BIOS gets confused if APIC was 
turned on (particularly on my laptop when I try to reboot from Linux it 
hangs saying that thera problems with keyboard). That would be much 
better to have an option to turn it off in the boot options and not to 
recompile the kernel. Could somebody comment this please?
Please CC me on this email address.

TIA,
Andriy


