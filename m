Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283876AbRLABg7>; Fri, 30 Nov 2001 20:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283880AbRLABgt>; Fri, 30 Nov 2001 20:36:49 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:24719 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S283878AbRLABgh>; Fri, 30 Nov 2001 20:36:37 -0500
Message-ID: <3C083424.7090309@optonline.net>
Date: Fri, 30 Nov 2001 20:36:36 -0500
From: Nathan Bryant <nbryant@optonline.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: i810 audio, problems with both GPL and 4Front driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


FYI,

On my machine, the changes in 
http://marc.theaimsgroup.com/?l=linux-kernel&m=100651447318071&w=2 or 
2.4.17-pre1 don't fix the KDE problems, as alleged. artsd still exits 
after consuming too much CPU. I've tried reducing fragment size to 512 
with no effect.

If it makes any difference to the driver, the kernel is running with 
APIC's and ACPI enabled on a uniprocessor build (Wow, acronym soup. ;)

for what it's worth, 4Front's binary driver (3.9.5, 3.9.6) has problems 
too on this machine. KDE works but there are audio pops/speedups/stops. 
(xmms, in particular, likes to stop for a while, then resume, sometimes 
after a speedup.)



