Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264697AbTABIXh>; Thu, 2 Jan 2003 03:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264867AbTABIXh>; Thu, 2 Jan 2003 03:23:37 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:42215 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S264697AbTABIXg>; Thu, 2 Jan 2003 03:23:36 -0500
Message-ID: <3E13F8FF.7060704@attbi.com>
Date: Thu, 02 Jan 2003 00:31:59 -0800
From: Miles Lane <miles.lane@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021129
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.54 -- amd-k8-agp.ko needs unknown symbol agp_memory_reserved
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

WARNING: /lib/modules/2.5.54/kernel/drivers/char/agp/amd-k8-agp.ko needs 
unknown symbol agp_memory_reserved


CONFIG_AGP=m
CONFIG_AGP_AMD=m
CONFIG_AGP_AMD_8151=m

Gnu C                  3.2
Gnu make               3.79.1
util-linux             2.11r
mount                  2.11r
module-init-tools      0.9.7
e2fsprogs              1.27
jfsutils               1.0.17
reiserfsprogs          3.6.2
pcmcia-cs              3.1.31
PPP                    2.4.1
isdn4k-utils           3.1pre4
Linux C Library        2.2.93
Dynamic linker (ldd)   2.2.93
Procps                 2.0.7
Net-tools              1.60
Kbd                    1.06
Sh-utils               2.0.12

