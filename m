Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293357AbSCUFOc>; Thu, 21 Mar 2002 00:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293361AbSCUFOX>; Thu, 21 Mar 2002 00:14:23 -0500
Received: from web14507.mail.yahoo.com ([216.136.224.70]:40209 "HELO
	web14507.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S293357AbSCUFOM>; Thu, 21 Mar 2002 00:14:12 -0500
Message-ID: <20020321051411.88407.qmail@web14507.mail.yahoo.com>
Date: Wed, 20 Mar 2002 21:14:11 -0800 (PST)
From: Bergs <flygong@yahoo.com>
Subject: How can I improve the speed of IP packet passing through linux box ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi friends:

 I work on a linux 2.2.14 kernel.I eager to improve
speed of IP packet passing through linux box.
 Can I call net_bh directly in function netif_rx() to
improve the speed of IP packet passing through LINUX
box ?
 And may you give some advice ? Thanks.

         Best regards
                            Bergs



__________________________________________________
Do You Yahoo!?
Yahoo! Movies - coverage of the 74th Academy Awards®
http://movies.yahoo.com/
