Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270210AbTGWLxA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 07:53:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270214AbTGWLxA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 07:53:00 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:36305 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S270210AbTGWLw7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 07:52:59 -0400
From: root@mauve.demon.co.uk
Message-Id: <200307231207.NAA29639@mauve.demon.co.uk>
Subject: USB problems (2.4.20) Device not accepting address=3 error=-110
To: linux-kernel@vger.kernel.org
Date: Wed, 23 Jul 2003 13:07:45 +0100 (BST)
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't seem to find where the error messages are defined.
I have a creative webcam (ov511) that will sometimes not be recognised
on boot (unplugging and replugging usually works).
/proc/bus/usb/devices does not show it if it is not recognised.
There are several other USB devices attatched that work, though they
are connected to a different port on the motherboard. (swapping
does not help)

Any ideas?
