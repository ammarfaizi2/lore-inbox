Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266649AbSLCXxB>; Tue, 3 Dec 2002 18:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266650AbSLCXxB>; Tue, 3 Dec 2002 18:53:01 -0500
Received: from mustang.centralnet.ch ([193.135.146.12]:9270 "EHLO
	mustang.centralnet.ch") by vger.kernel.org with ESMTP
	id <S266649AbSLCXxA>; Tue, 3 Dec 2002 18:53:00 -0500
Message-ID: <3DED45ED.1A70773A@vollmann.ch>
Date: Wed, 04 Dec 2002 01:01:49 +0100
From: Detlef Vollmann <dv@vollmann.ch>
Organization: vollmann engineering gmbh
X-Mailer: Mozilla 3.04 (X11; U; Linux 2.4.18-xfs-1.1 i686)
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: modutils needs query_module
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

modutils-2.4.22 uses query_module, but that's not any more
in the kernel (at least not in 2.5.50).
Is there a newer modutils anywhere, or do I need a new glibc
(currently I use 2.2.5) or do I miss something?

Detlef

-- 
Detlef Vollmann
vollmann engineering gmbh           Tel: +41-41-4120911
P.O. Box 5106                       Fax: +41-41-4120912
CH-6000 Luzern 5 / Switzerland      eMail: dv@vollmann.ch
