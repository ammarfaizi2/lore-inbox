Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264286AbUARXef (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 18:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264290AbUARXef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 18:34:35 -0500
Received: from colossus.systems.pipex.net ([62.241.160.73]:29882 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S264286AbUARXee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 18:34:34 -0500
From: Roman Gaufman <hackeron@dsl.pipex.com>
Reply-To: hackeron@dsl.pipex.com
To: linux-kernel@vger.kernel.org
Subject: ACPI/APM problems with >=2.6-test4
Date: Sun, 18 Jan 2004 23:43:02 +0000
User-Agent: KMail/1.5.94
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401182343.03076.hackeron@dsl.pipex.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

prior to 2.6-test4, my Fujitsu P2110 laptop's suspend has worked perfect via 
APM, since kernel 2.6-test4 I have experienced problems, on 2.6-test4 laptop 
would sometimes not resume from suspend, and since test5 it would no longer 
resume at all :(, I'm now running on 2.6.1-mm and it just shows resuming on 
screen, and freezes.

I am not sure how to track problem, but if anyone has any ideas what could be 
wrong, please let me know.

Also having suspend resume problems on my Compaq Presario 2100us laptop (model 
with Celeron) here it doesn't show resuming messages, just freezes on resume 
attempt.

Yours
Roman Gaufman
