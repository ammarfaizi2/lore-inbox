Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751286AbVI1NrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVI1NrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 09:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVI1NrA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 09:47:00 -0400
Received: from c71.sam-solutions.net ([217.21.35.67]:6448 "EHLO
	c71.sam-solutions.net") by vger.kernel.org with ESMTP
	id S1751286AbVI1Nq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 09:46:59 -0400
Subject: Switching output console on the fly
From: Yura Pakhuchiy <y.pakhuchi@sam-solutions.net>
Reply-To: Yura Pakhuchiy <pakhuchiy@gmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: SaM-Solutions
Date: Wed, 28 Sep 2005 16:47:44 +0300
Message-Id: <1127915264.10759.11.camel@pc299.sam-solutions.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-alt2) 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Sep 2005 13:46:57.0426 (UTC) FILETIME=[17F55F20:01C5C433]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I can select consoles to which print kernel output by passing "console="
parameter to kernel during boot. Is it possible to change this console
later, or add/remove console to list of consoles on which output is
printed?

-- 
Best regards,
        Yura

