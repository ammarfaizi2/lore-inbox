Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131351AbRC0PLx>; Tue, 27 Mar 2001 10:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131353AbRC0PLn>; Tue, 27 Mar 2001 10:11:43 -0500
Received: from [213.97.45.174] ([213.97.45.174]:17412 "EHLO pau.intranet.ct")
	by vger.kernel.org with ESMTP id <S131351AbRC0PLg>;
	Tue, 27 Mar 2001 10:11:36 -0500
Date: Tue, 27 Mar 2001 17:10:19 +0200 (CEST)
From: Pau Aliagas <linux4u@wanadoo.es>
X-X-Sender: <pau@pau.intranet.ct>
To: lkml <linux-kernel@vger.kernel.org>
Subject: 2.4.2-ac26 -> processes in D state
Message-ID: <Pine.LNX.4.33.0103271707450.1749-100000@pau.intranet.ct>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've tried 2.4.2-ac26 to test the new xircom_cb driver but I have had to
reboot on 2.4.3-pre7 as some processes got stuck on D state.
The processes were large apps: once nautilus and once mozilla.
I couldn't get any other information.

Pau

