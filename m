Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270634AbRIJL3g>; Mon, 10 Sep 2001 07:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270585AbRIJL3Q>; Mon, 10 Sep 2001 07:29:16 -0400
Received: from ns1.yggdrasil.com ([209.249.10.20]:40929 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S270634AbRIJL3M>; Mon, 10 Sep 2001 07:29:12 -0400
Date: Mon, 10 Sep 2001 04:29:32 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: linux-kernel@vger.kernel.org
Cc: eokerson@quicknet.net
Subject: linux-2.4.10-pre7/drivers/telephony/ixj{,_pcmcia}.c does not compile
Message-ID: <20010910042932.A893@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	linux-2.4.10-pre7/drivers/telphony/ixj.h refers to an
undefined type IXJ_SIGDEF, preventing ixj_pcmcia.c and ixj.c in
that directory from compiling.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
