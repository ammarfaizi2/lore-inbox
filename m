Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264070AbRFESmW>; Tue, 5 Jun 2001 14:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264071AbRFESmC>; Tue, 5 Jun 2001 14:42:02 -0400
Received: from imr2.ericy.com ([12.34.240.68]:51955 "EHLO imr2.ericy.com")
	by vger.kernel.org with ESMTP id <S264070AbRFESmA>;
	Tue, 5 Jun 2001 14:42:00 -0400
From: "David Gordon (LMC)" <David.Gordon@ericsson.ca>
To: linux-kernel@vger.kernel.org
Message-ID: <3B1D27E2.7080701@lmc.ericsson.se>
Date: Tue, 05 Jun 2001 14:41:38 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; m18) Gecko/20001107 Netscape6/6.0
X-Accept-Language: en
MIME-Version: 1.0
Subject: kHTTPd hangs 2.4.5 boot when moduled
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

CC at david.gordon@erisson.ca if reply

I found that when kHTTPd is compiled as a module, kernel 2.4.5 will hang 
at boot. However, when kHTTPd is omitted or compiled into the kernel, 
the boot is okay.

I run an Intel RH7.0 machine.

David Gordon
