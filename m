Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266452AbUBLOKw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 09:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUBLOKw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 09:10:52 -0500
Received: from isec.pl ([193.110.121.50]:64131 "EHLO isec.pl")
	by vger.kernel.org with ESMTP id S266452AbUBLOKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 09:10:50 -0500
Date: Thu, 12 Feb 2004 15:10:43 +0100 (CET)
From: Wojciech Purczynski <cliph@isec.pl>
To: jgarzik@pobox.com, <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: drivers/net/tg3.h out of date in 2.4.25rc2
Message-ID: <Pine.LNX.4.44.0402121457520.30421-100000@isec.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It seems that tg3.h header file is out of date. The updated Tigon3 driver
does not compile correctly because of few missing definitions.

Regards,
wp

PS: Please CC me.

-- 
Wojciech Purczynski
iSEC Security Research
http://isec.pl/


