Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316757AbSHJJ4a>; Sat, 10 Aug 2002 05:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSHJJ43>; Sat, 10 Aug 2002 05:56:29 -0400
Received: from p3E99065B.dip.t-dialin.net ([62.153.6.91]:55309 "EHLO
	salem.getuid.de") by vger.kernel.org with ESMTP id <S316757AbSHJJ43>;
	Sat, 10 Aug 2002 05:56:29 -0400
Date: Sat, 10 Aug 2002 11:14:34 +0200
From: Christian Kurz <shorty@getuid.de>
To: linux-kernel@vger.kernel.org
Subject: modules missing author name and/or description
Message-ID: <20020810091434.GM23894@salem.getuid.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: True happiness will be found only in true love.
Mail-Copies-To: never
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just played with lsmod and modinfo and noticed that the following
modules which I use either lack one or both of the information I
mentioned in the description. The following modules lack the name of the
author:

lp.o
parport.o
ipt_REJECT.o
ipt_LOG.o
ipt_state.o
ip_conntrack.o
ip_conntrack_ftp.o
iptable_filter.o
ip_tables.o
slhc.o
jbd.o
unix.o (mentioned in a seperate message already)

The following modules lack a description:

lp.o
parport.o
ipt_REJECT.o
ipt_LOG.o
ipt_state.o
ip_conntrack.o
ip_conntrack_ftp.o
iptable_filter.o
iptables.o
agpgart.o
slhc.o
jbd.o
unix.o

I would be nice if these missing informations would be added to the
modules. This result was produced with the 2.4.20-pre1 kernel.

Christian
-- 
We must learn to live together like brothers,
or we shall die together like fools.
                -- Martin Luther King
