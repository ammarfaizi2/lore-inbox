Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317359AbSHJWv1>; Sat, 10 Aug 2002 18:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317366AbSHJWv1>; Sat, 10 Aug 2002 18:51:27 -0400
Received: from hq.pm.waw.pl ([195.116.170.10]:2689 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S317359AbSHJWv0>;
	Sat, 10 Aug 2002 18:51:26 -0400
To: <linux-kernel@vger.kernel.org>
Cc: marcelo@conectiva.com.br
Subject: [PATCH] 2.4.20-pre1 warnings cleanup
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 11 Aug 2002 00:54:04 +0200
Message-ID: <m3y9be2ulv.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch clears some compiler warning messages from 2.4.20-pre1
and eliminates unused code.
-- 
Krzysztof Halasa
Network Administrator
