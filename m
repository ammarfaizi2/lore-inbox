Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263765AbTE3P6Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 11:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263766AbTE3P6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 11:58:25 -0400
Received: from mailout09.sul.t-online.com ([194.25.134.84]:55273 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S263765AbTE3P6Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 11:58:25 -0400
Message-Id: <5.1.0.14.2.20030530180058.00af0290@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 30 May 2003 18:11:49 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: drivers/char/sysrq.c
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wonder if there are other places where "&" (or "|") is coded and
"&&" (or "||") is meant (or vice-versa) where the result is NOT semantically
the same :-)
It'll take a good checker to sort that one!

Margit

