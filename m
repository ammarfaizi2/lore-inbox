Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266712AbUFRTyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266712AbUFRTyR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 15:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266790AbUFRTxg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 15:53:36 -0400
Received: from [200.35.87.214] ([200.35.87.214]:8579 "EHLO mail.conectium.com")
	by vger.kernel.org with ESMTP id S266712AbUFRTvS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 15:51:18 -0400
Date: Fri, 18 Jun 2004 15:51:17 -0400
From: Adrian Almenar <aalmenar@conectium.com>
To: linux-kernel@vger.kernel.org
Subject: sysfs directories...
Message-Id: <20040618155117.0bffd01d@er-murazor.conectium.com>
Organization: Conectium Limited
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: {26'70MqsTLde"U<<p1BH%h{duzku6&wzF~Fi`jXR{;rJy4Qd_%$d,-zdy[ASvbbC{Enb{7
 bnq^D{D$2zCnLU]>cF)hs&V^ess60$y6yQBGWf"][NlZuHkPl4#Ga*|t|Nj[LvpH
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ConectiumLimited-MailScanner-Information: Please contact Conectium Limited for more information
X-ConectiumLimited-MailScanner: Found to be clean
X-ConectiumLimited-MailScanner-SpamCheck: no es spam (whitelisted),
	SpamAssassin (puntaje=-6, requerido 5, autolearn=not spam,
	BAYES_00 -6.00)
X-MailScanner-From: aalmenar@conectium.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i was looking at /sys on my machine yesterday and i found something
strange.

cd
/sys/block/hda/device/block/device/block/device/block/device/block/...
and that continues being almost infinite and recursive, it is normal
???

My Kernel Version is: 2.6.7-rc3

Cheers,

-- 
Adrian Almenar
