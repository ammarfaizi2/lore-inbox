Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272435AbTHEFKP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 01:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272437AbTHEFKO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 01:10:14 -0400
Received: from www.erfrakon.de ([193.197.159.57]:62217 "EHLO www.erfrakon.de")
	by vger.kernel.org with ESMTP id S272435AbTHEFKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 01:10:10 -0400
From: Martin Konold <martin.konold@erfrakon.de>
Organization: erfrakon
To: linux-kernel@vger.kernel.org
Subject: Interactive Usage of 2.6.0.test1 worse than 2.4.21
Date: Tue, 5 Aug 2003 07:04:22 +0200
User-Agent: KMail/kroupware-1.0.0
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308050704.22684.martin.konold@erfrakon.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

when using  2.6.0.test1 on a high end laptop (P-IV 2.2 GHz, 1GB RAM) I notice 
very significant slowdown in interactive usage compared to 2.4.21.

The difference is most easily seen when switching folders in kmail. While 
2.4.21 is instantaneous 2.6.0.test1 shows the clock for about 2-3 seconds.

I am using maildir folders on reiserfs.

Can anyone verify this behaviour?

What other information do you need?

Regards,
-- martin

Dipl.-Phys. Martin Konold
e r f r a k o n
Erlewein, Frank, Konold & Partner - Beratende Ingenieure und Physiker
Nobelstrasse 15, 70569 Stuttgart, Germany
fon: 0711 67400963, fax: 0711 67400959
email: martin.konold@erfrakon.de

