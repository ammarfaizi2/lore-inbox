Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312675AbSC0GEa>; Wed, 27 Mar 2002 01:04:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312676AbSC0GEU>; Wed, 27 Mar 2002 01:04:20 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:6813 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S312675AbSC0GEH>; Wed, 27 Mar 2002 01:04:07 -0500
Date: Wed, 27 Mar 2002 07:53:28 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH][RFC] P4/Xeon Thermal LVT support
Message-ID: <Pine.LNX.4.44.0203270751400.22305-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,
	This patch enables thermal monitoring on P4/Xeon and also installs 
an interrupt handler to take notification of thermal state transitions. 
Its currently untested, so input would be appreciated.

Thanks,
	Zwane

-- 
http://function.linuxpower.ca
		

