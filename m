Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268575AbUI2O5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268575AbUI2O5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268633AbUI2Oyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:54:32 -0400
Received: from fw-sth.ingate.se ([62.181.225.250]:1788 "EHLO mhoram.ingate.se")
	by vger.kernel.org with ESMTP id S268536AbUI2OoW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:44:22 -0400
Message-ID: <415ACA3C.908@ingate.com>
Date: Wed, 29 Sep 2004 16:44:12 +0200
From: Marcus Sundberg <marcus@ingate.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en, sv
MIME-Version: 1.0
To: jeremy@goop.org
CC: linux-kernel@vger.kernel.org
Subject: Unsupported speedstep
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my 1.1 GHz dothan apparently isn't supported yet. I've seen patches for
stepping 6 1.5GHz and up, but none for 1.1 GHz, so here's the /proc/cpuinfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 6
model		: 13
model name	: Intel(R) Pentium(R) M processor 1.10GHz
stepping	: 6
cpu MHz		: 1100.152
cache size	: 64 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 mtrr pge mca cmov pat clflush dts acpi mmx fxsr sse sse2 ss tm pbe tm2 est
bogomips	: 2170.88

//Marcus
-- 
---------------------------------------+--------------------------
   Marcus Sundberg <marcus@ingate.com>  | Firewalls with SIP & NAT
  Firewall Developer, Ingate Systems AB |  http://www.ingate.com/
