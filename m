Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268263AbUHFTyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268263AbUHFTyM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268271AbUHFTwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:52:18 -0400
Received: from asmtp-a063f35.pas.sa.earthlink.net ([207.217.120.220]:5560 "EHLO
	asmtp-a063f35.pas.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S268270AbUHFTum (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:50:42 -0400
Message-ID: <4113E0FE.1040506@networkstreaming.com>
Date: Fri, 06 Aug 2004 14:50:22 -0500
From: Davy Durham <davy@networkstreaming.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: disabling all video
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: fecd8eaa9fd3d07f1b1abadc42a7f14674bf435c0eb9d47882885355c204f66b0b128ab792b17cb0a29c447f8fe0445b350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 65.217.35.159
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry if this is the wrong list to ask this.. direct me to the correct 
list if so...

Question: I would like the kernel not to use any of the video hardware 
on the machine.  Is there any run-time kernel parameter I can pass to 
disable all video?  (I tried console= to direct output to the serial 
port, but ttys were still using the vga hardware.)  My video card is 
built onto the mother board, and there is no way I see to disable it 
from the BIOS. 

I was hoping there was an option such as vga=disable or video=null or 
something like that, but I've looked thru the docs and cannot find anything.

Thanks,
  Davy

