Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318289AbSHEDAA>; Sun, 4 Aug 2002 23:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318290AbSHEDAA>; Sun, 4 Aug 2002 23:00:00 -0400
Received: from spud.dpws.nsw.gov.au ([203.202.119.24]:48867 "EHLO
	spud.dpws.nsw.gov.au") by vger.kernel.org with ESMTP
	id <S318289AbSHEC77>; Sun, 4 Aug 2002 22:59:59 -0400
Message-Id: <sd4e738d.059@out-gwia.dpws.nsw.gov.au>
X-Mailer: Novell GroupWise Internet Agent 6.0.1
Date: Mon, 05 Aug 2002 12:45:37 +1000
From: "Daniel Lim" <Daniel.Lim@dpws.nsw.gov.au>
To: <linux-kernel@vger.kernel.org>
Subject: Swap not used after  kernel upgrade
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-NAIMIME-Disclaimer: 1
X-NAIMIME-Modified: 1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
After successfully upgraded to SMP kernel 2.4.9-34 the swap partition
appears not being used,  prior to the upgrade on previous kernel 2.4.2-2
the swap was about 10% utilized. 

The free command gives 0 used, top and sar also report same.
                    total       used       free     shared    buffers  
  cached
Mem:       1027972    1015152      12820         64     171292    
592108
-/+ buffers/cache:     251752     776220
Swap:      2097112          0    2097112

Any idea please.
Thanks in advance,
Daniel



 This e-mail message (and attachments) is confidential, and / or privileged and is intended for the use of the addressee only. If you are not the intended recipient of this e-mail you must not copy, distribute, take any action in reliance on it or disclose it to anyone. Any confidentiality or privilege is not waived or lost by reason of mistaken delivery to you. DPWS is not responsible for any information not related to the business of DPWS. If you have received this e-mail in error please destroy the original and notify the sender.

For information on services offered by DPWS, please visit our website at www.dpws.nsw.gov.au



