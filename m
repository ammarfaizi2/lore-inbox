Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271162AbSISPsB>; Thu, 19 Sep 2002 11:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271302AbSISPsB>; Thu, 19 Sep 2002 11:48:01 -0400
Received: from web14510.mail.yahoo.com ([216.136.224.169]:39684 "HELO
	web14510.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S271162AbSISPsA>; Thu, 19 Sep 2002 11:48:00 -0400
Message-ID: <20020919154545.17347.qmail@web14510.mail.yahoo.com>
Date: Thu, 19 Sep 2002 08:45:45 -0700 (PDT)
From: Kent Hunt <kenthunt@yahoo.com>
Subject: Compile error 2.4.20-pre7 in ip_conntrackt_ftp
To: lk <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI

ip_conntrack_ftp.c:440: parse error before
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
ip_conntrack_ftp.c:440: warning: type defaults to
`int' in declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
ip_conntrack_ftp.c:440: warning: data definition has
no type or storage class

Please CC.

Kent

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
