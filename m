Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbTFBHyf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 03:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbTFBHyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 03:54:35 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:44216 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S262028AbTFBHye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 03:54:34 -0400
Message-Id: <5.1.0.14.2.20030602094232.00aeda18@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 02 Jun 2003 09:53:04 +0200
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: SCTP config 2.5.70(-bk)
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_IPV6_SCTP__   is always being set to "y" even though
not selected (CONFIG_IPV6 not set)

Margit

