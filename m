Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752106AbWAEHps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbWAEHps (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 02:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107AbWAEHps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 02:45:48 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:25537 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1752106AbWAEHpr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 02:45:47 -0500
Date: Thu, 5 Jan 2006 08:45:36 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jeff Dike <jdike@addtoit.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH 4/9] UML - Better diagnostics for broken configs
In-Reply-To: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.61.0601050844550.10161@yvahk01.tjqt.qr>
References: <200601042151.k04LpxbH009237@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Produce a compile-time error if both MODE_SKAS and MODE_TT are disabled.
>
What would happen if both were disabled?
Say, if the host system does not have SKAS and I did not want any 
tracing/debugging stuff?



Jan Engelhardt
-- 
