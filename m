Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289855AbSBKRRd>; Mon, 11 Feb 2002 12:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289858AbSBKRRN>; Mon, 11 Feb 2002 12:17:13 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:64474 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S289855AbSBKRRI>;
	Mon, 11 Feb 2002 12:17:08 -0500
Message-ID: <3C6808E7.7F8BC131@vnet.ibm.com>
Date: Mon, 11 Feb 2002 12:09:43 -0600
From: Tom Gall <tom_gall@vnet.ibm.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2 ppc)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.4, cs46xx snd, and virt_to_bus
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

  Well forgive me for not being up on the lastest news but from building
2.5.4 kernel for my box, which uses the cs46xx.c sound driver, it would
appear that virt_to_bus and bus_to_virt has gone the way of the do-do. 

  What's the correct method now? 

  Be nice to get this cleaned up....

  Regards,

  Tom

-- 
Tom Gall - [embedded] [PPC64 | PPC32] Code Monkey
Peace, Love &                  "Where's the ka-boom? There was
Linux Technology Center         supposed to be an earth
http://www.ibm.com/linux/ltc/   shattering ka-boom!"
(w) tom_gall@vnet.ibm.com       -- Marvin Martian
(w) 507-253-4558
(h) tgall@rochcivictheatre.org
