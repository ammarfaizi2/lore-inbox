Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270003AbTHLKtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 06:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270007AbTHLKtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 06:49:20 -0400
Received: from ms-smtp-02.rdc-kc.rr.com ([24.94.166.122]:49137 "EHLO
	ms-smtp-02.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S270003AbTHLKtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 06:49:19 -0400
Subject: X freezing in 2.4.21
From: david nicol <davidnicol@pay2send.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1060685356.1249.21.camel@plaza.davidnicol.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Aug 2003 05:49:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I believe it to be gnome's problem, since I don't get lock-ups
under fvwm.

Anyway how difficult would it be to gracefully handle jump-to-null
and why is that causing a panic instead of just one process expiring?

My guess is it has to do with the DRM support.  

