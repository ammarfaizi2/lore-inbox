Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272795AbRIRIW6>; Tue, 18 Sep 2001 04:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272797AbRIRIWt>; Tue, 18 Sep 2001 04:22:49 -0400
Received: from [209.10.41.242] ([209.10.41.242]:46749 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S272795AbRIRIWi>;
	Tue, 18 Sep 2001 04:22:38 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Cc: kdb@oss.sgi.com
Subject: kdb v1.8-2.4.10-pre11
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 18 Sep 2001 18:10:49 +1000
Message-ID: <10797.1000800649@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://oss.sgi.com/projects/kdb/download/ix86/kdb-v1.8-2.4.10-pre11.bz2
compiles (if you have a compiler that understands __builtin_expect) and
runs for me.  I have no idea if the information printed by modules
kdbm_vm and kdbm_pg is still valid, would any VM expert care to check
kdb against the latest VM changes?  All patches gratefully accepted.

