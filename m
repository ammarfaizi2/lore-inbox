Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263183AbUCMUTh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 15:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUCMUTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 15:19:37 -0500
Received: from knight-linux.rlknight.com ([64.165.88.6]:52228 "EHLO
	knight-linux.rlknight.com") by vger.kernel.org with ESMTP
	id S263183AbUCMUTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 15:19:32 -0500
Message-ID: <40536865.5010008@rlknight.com>
Date: Sat, 13 Mar 2004 12:00:37 -0800
From: Rick Knight <rick_knight@rlknight.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Intel 536EP Modem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an Intel 536EP modem I would like to be able to use with linux. I 
have kernel 2.6.3 installed. I notice that the  modem is detected by the 
system and several files in the kernel source tree have make reference 
to it...

#grep -rn '536EP' /usr/src/linux-2.6.3 yields

Binary file arch/i386/boot/compressed/vmlinux.bin matches
Binary file drivers/pci/built-in.o matches
drivers/pci/pci.ids:6672:    1040  536EP Data Fax Modem
drivers/pci/devlist.h:7905:    DEVICE(8086,1040,"536EP Data Fax Modem")
Binary file drivers/pci/names.o matches
Binary file drivers/built-in.o matches
Binary file vmlinux matches

Is it possible to get this modem to work?


In answering this message, please CC me.

Thanks for your help,
Rick Knight
(rick@rlknight.com)

