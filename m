Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268894AbUIQRix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbUIQRix (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 13:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268911AbUIQRix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 13:38:53 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:42213 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268894AbUIQRis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 13:38:48 -0400
Message-ID: <1a56ea3904091710382c2f8710@mail.gmail.com>
Date: Fri, 17 Sep 2004 18:38:46 +0100
From: DaMouse <damouse@gmail.com>
Reply-To: DaMouse <damouse@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: FASTCALL fixing?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,
       I get errors about the fastcall and type conflicts in 2.4.27
(yeah its old.. i know :) ) I was wondering what the politically
correct way of fixing these are? adding fastcall type to
kernel/sched.c or removing FASTCALL() around it in sched.h?

-DaMouse
-- 
I know I broke SOMETHING but its there fault for not fixing it before me
