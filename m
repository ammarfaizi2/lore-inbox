Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbUKXOQR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbUKXOQR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUKXONE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:13:04 -0500
Received: from grendel.digitalservice.pl ([217.67.200.140]:7336 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262701AbUKXN4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:56:47 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: 2.6.10-rc2-mm3: console blanking hangs, er, console (on AMD64)
Date: Wed, 24 Nov 2004 14:26:10 +0100
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200411241426.10926.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2.6.10-rc2-mm3 console blanking makes the keyboard unresponsive on my box 
(Athlon 64 + Nforce3 + GeForce Go, SuSE 9.1 /AMD64).  No big deal, but 
annoying (I have to use the power button to shut the system down and it shuts 
down cleanly w/ ACPI).

Greets,
RJW

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
