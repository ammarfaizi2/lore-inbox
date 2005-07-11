Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVGKGcI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVGKGcI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 02:32:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbVGKGcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 02:32:08 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:31699 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262262AbVGKGcH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 02:32:07 -0400
Date: Mon, 11 Jul 2005 09:32:00 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add kerneldoc reference to CodingStyle
Message-ID: <Pine.LNX.4.58.0507110931290.8748@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 CodingStyle |    3 +++
 1 files changed, 3 insertions(+)

Index: 2.6/Documentation/CodingStyle
===================================================================
--- 2.6.orig/Documentation/CodingStyle
+++ 2.6/Documentation/CodingStyle
@@ -236,6 +236,9 @@ ugly), but try to avoid excess.  Instead
 of the function, telling people what it does, and possibly WHY it does
 it.
 
+When commenting the kernel API functions, please use the kerneldoc format.
+See the file scripts/kernel-doc for details.
+
 
 		Chapter 8: You've made a mess of it
 
