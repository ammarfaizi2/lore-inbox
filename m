Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292330AbSBBRz6>; Sat, 2 Feb 2002 12:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292332AbSBBRzs>; Sat, 2 Feb 2002 12:55:48 -0500
Received: from as1-4-7.bn.g.bonet.se ([194.236.61.89]:25473 "HELO cucumelo.org")
	by vger.kernel.org with SMTP id <S292330AbSBBRzd>;
	Sat, 2 Feb 2002 12:55:33 -0500
Message-ID: <3C5C7C66.1050007@cucumelo.org>
Date: Sat, 02 Feb 2002 18:55:18 -0500
From: Benny Sjostrand <gorm@cucumelo.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010914
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 512 Mb DIMM not detected by the BIOS!
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone!

I'm new to this mailinglist so please tellme if you think i'm "out of 
topoic".

I've have trouble with the following issue:
On two x86 machines, one AMD k62 and a Pentium the Bios dont wont to 
detect properly a 512 MB PC133 DIMM, the K62 based it dont detect it at 
all, and on the PII it detect it as a 128MB DIMM.
I suspect that's the BIOS that "sucks", not the HW, i supose that the HW 
is capable to deal with 512MB DIMM's, so my question to you 
"kernel-gurus", is there any posibility to configure the Linux kernel to 
bypass the BIOS and actually use my 512MB ?

Thanks!

/Benny


