Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266200AbSL1Kcz>; Sat, 28 Dec 2002 05:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266203AbSL1Kcz>; Sat, 28 Dec 2002 05:32:55 -0500
Received: from fmr06.intel.com ([134.134.136.7]:64760 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S266200AbSL1Kcy>; Sat, 28 Dec 2002 05:32:54 -0500
Message-ID: <957BD1C2BF3CD411B6C500A0C944CA2601AA1378@pdsmsx32.pd.intel.com>
From: "Zhuang, Louis" <louis.zhuang@intel.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fix os release detection in module-init-tools-0.9.6 
Date: Sat, 28 Dec 2002 18:38:54 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now, why do you want /proc/ksyms exactly?  I'm not hugely opposed to
> it, but it's rarely what people actually want, since it contains only
> exported symbols.
The two things make me want ksyms... ;-)
First, if I'm a stranger to a system, how can I know if a feature
(preemptive, for example) is on/off on that?
Second, when module version is back, how can I know what is the magic
version number on the system?

Yours truly,
  - Louis
