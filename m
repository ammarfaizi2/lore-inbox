Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318661AbSHEQMp>; Mon, 5 Aug 2002 12:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318589AbSHEQLF>; Mon, 5 Aug 2002 12:11:05 -0400
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:7116 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S318661AbSHEQJ2>; Mon, 5 Aug 2002 12:09:28 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Arnd Bergmann <arndb@de.ibm.com>
Reply-To: arnd@bergmann-dalldorf.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: 0/18 2.4.19 architecture updates for s390 following
Date: Mon, 5 Aug 2002 20:12:14 +0200
User-Agent: KMail/1.4.2
Organization: IBM Deutschland Entwicklung GmbH
Cc: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208051830.50713.arndb@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Last friday, we had a new code drop on developerworks with 
s390 patches against 2.4.17. The patches following this mail 
contain that code, updated to 2.4.19. They were prepared by Martin 
Schwidefsky, but he's on holidays now, so I'm sending them instead.

The first eleven patches contains large updates for s390 architecture 
dependent files that are maintained here, so I'm not sending
them to lkml. The rest are smaller bits, some of which are more
controversial.

	Arnd <><
