Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272679AbRIGOpq>; Fri, 7 Sep 2001 10:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272682AbRIGOpg>; Fri, 7 Sep 2001 10:45:36 -0400
Received: from rcum.uni-mb.si ([164.8.2.10]:63245 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S272679AbRIGOp1>;
	Fri, 7 Sep 2001 10:45:27 -0400
Date: Fri, 07 Sep 2001 16:45:39 +0200
From: David Balazic <david.balazic@uni-mb.si>
Subject: /proc/cpuinfo bad cache info
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-id: <3B98DD93.4BDD367C@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In recent 2.4.x kernels the "Cache: " line in /proc/cpuinfo
reports the amount of the L1 cache or L2 cache or L3 cache or
some combination of them, depending on what code is executed
for this ( different for different CPU types ).

Somebody should decide what information should be reported in that
line and then fix the code.

Party on !

-- 
David Balazic
--------------
"Be excellent to each other." - Bill S. Preston, Esq., & "Ted" Theodore Logan
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
