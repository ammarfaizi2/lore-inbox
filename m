Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbSL2GMU>; Sun, 29 Dec 2002 01:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266478AbSL2GMU>; Sun, 29 Dec 2002 01:12:20 -0500
Received: from jive.SoftHome.net ([66.54.152.27]:27529 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id <S265378AbSL2GMT>;
	Sun, 29 Dec 2002 01:12:19 -0500
Subject: [PATCH 2.5] bttv-cards.c AUDC_CONFIG_PINNACLE fix
From: Steven Barnhart <sbarn03@softhome.net>
To: alan@redhat.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Dec 2002 01:20:35 -0500
Message-Id: <1041142844.12913.8.camel@sbarn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes bug #162 on http://bugme.osdl.org that has still not been
merged with mainline since it appeared in 2.5.51. This patch gets rid of
the undeclared AUDC_CONFIG_PINNACLE problem. Please merge.

Steven Barnhart
sbarn03@softhome.net



