Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318117AbSHGQRA>; Wed, 7 Aug 2002 12:17:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318216AbSHGQRA>; Wed, 7 Aug 2002 12:17:00 -0400
Received: from pg-fw.paradigmgeo.com ([192.117.235.33]:601 "EHLO
	ntserver2.geodepth.com") by vger.kernel.org with ESMTP
	id <S318117AbSHGQQ7>; Wed, 7 Aug 2002 12:16:59 -0400
Message-ID: <EE83E551E08D1D43AD52D50B9F511092E114DE@ntserver2>
From: Gregory Giguashvili <Gregoryg@ParadigmGeo.com>
To: "Linux Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: O_SYNC option doesn't work (2.4.18-3)
Date: Wed, 7 Aug 2002 19:17:51 +0200 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wonder if someone knows why files open with O_SYNC option on an NFS
mounted drive don't get synchronized? Is it an open issue?
The directory is both exported and mounted using sync option.

Thanks in advance.
Giga
