Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262588AbVAVQi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262588AbVAVQi1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 11:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVAVQi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 11:38:27 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:60141 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id S262588AbVAVQi0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 11:38:26 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200501221638.j0MGcPce001588@clem.clem-digital.net>
Subject: pre 2.6.11 Possible Memory Leak
To: linux-kernel@vger.kernel.org (linux-kernel)
Date: Sat, 22 Jan 2005 11:38:25 -0500 (EST)
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed a couple posts regarding possible memory leak
in pre 2.6.11. I have also observed the problem, but
wrote it off to running VMware and the pgtbl changes.
Running VMware will cause all memory to be consumed in
a matter of several hours. Just a data point.
-- 
Pete Clements 
