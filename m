Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319088AbSHFOJa>; Tue, 6 Aug 2002 10:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319092AbSHFOJa>; Tue, 6 Aug 2002 10:09:30 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:960 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S319088AbSHFOJ2>; Tue, 6 Aug 2002 10:09:28 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: clear dentry and inode cache
Date: Tue, 6 Aug 2002 16:12:58 +0200
User-Agent: KMail/1.4.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208061612.58825.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there a a way to clear the dentry and inode cache via proc interface ?

Sometimes all the clients of our groups have problems with stale nfs file 
handles (and currently also UNFSD/ClusterNFS problems, though this will 
finish soon), and we (the admins) think that this could be solved by clearing 
the cache -- please correct me if I'm wrong.

Thanks in advance,

Bernd

-- 
Bernd Schubert
Physikalisch Chemisches Institut
Abt. Theoretische Chemie
INF 229, 69120 Heidelberg
Tel.: 06221/54-5210
e-mail: 	bernd (dot) schubert (at) pci (dot) uni-heidelberg (dot) de 
