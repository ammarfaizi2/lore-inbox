Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261310AbSKXNwX>; Sun, 24 Nov 2002 08:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261305AbSKXNwX>; Sun, 24 Nov 2002 08:52:23 -0500
Received: from services.cam.org ([198.73.180.252]:31507 "EHLO mail.cam.org")
	by vger.kernel.org with ESMTP id <S261310AbSKXNwX>;
	Sun, 24 Nov 2002 08:52:23 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Invalid module format - how does one fix this?
Date: Sun, 24 Nov 2002 08:59:35 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200211240859.35516.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.5.49-mm1 works ok here (shpte enabled too).  I see two frustrating problems left
with the modules change (user perspective).  The most irratating one is messages like:

FATAL: Error inserting /lib/modules/2.5.49-mm1/kernel/ac97_codec.o: Invalid module format

I get this on about 10% of the modules I want to load.  How do I fix it?

The second is that automatic loading is not working.  Manually loading modules is a PITA.
What plans are there to fix this?

TIA
Ed Tomlinson
