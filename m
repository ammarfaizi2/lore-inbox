Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263885AbTKJPMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 10:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263902AbTKJPMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 10:12:53 -0500
Received: from gemini.smart.net ([205.197.48.109]:9988 "EHLO gemini.smart.net")
	by vger.kernel.org with ESMTP id S263885AbTKJPMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 10:12:52 -0500
Message-ID: <3FAFA9FF.13F3CBB8@smart.net>
Date: Mon, 10 Nov 2003 10:08:47 -0500
From: "Daniel B." <dsb@smart.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18+dsb+smp+ide i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: loop device lockup bugs in 2.4.18? (hangs with multiCD --noburn=1)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there any known or suspected bugs with loop devices in 2.4.18?

Running multiCD with CD-burning disabled ("multiCD --noburn=1"),
my system frequently hangs (e.g., Caps Lock key doesn't even toggle
the Caps Lock LED).

The main thing that multiCD does (when not actually burning CDs)
seems to be manipulating CD-size ext2 filesystem files via loopback.

Thanks,
Daniel
-- 
Daniel Barclay
dsb@smart.net
