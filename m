Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261428AbVGDQJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbVGDQJK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 12:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261390AbVGDQIR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 12:08:17 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:55028 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261230AbVGDQF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 12:05:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=kv7MmDyzgorlfCdDAprIPUvyvvG9swioWqIkBpl9X0Zg0OMdfmF8zkc5uOnPpm+0dKAIQUxeSChVxIr7URU/n689RR5gF1Etc1ootO4BvaUAxonr1mSGCgOIVwGnQWoJHNsxPVtQs9PPIdIkM26SOP8kDbgNJwwIFAHxo/eRESg=
Subject: notebook buttons trouble, acpi related
From: Hetfield <hetfield666@gmail.com>
Reply-To: hetfield666@gmail.com
To: Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 04 Jul 2005 18:05:52 +0200
Message-Id: <1120493152.17493.30.camel@blight.blightgroup>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

i have a problem with my Asus a1000 notebook.

some buttons, like video switch, mute on/off, brightness up/down
are not detected by acpi nor keyboard driver.

the strange thing is that brightness works and video switch turn on/off
my tft (can't enable other video mode, but this is not a trouble).

if it turns off tft and change brightness i guess kernel should receive
some events but
/proc/acpi/event doesn't get them.

how can i see what happens when i press those keys?

acpi4asus doesn't support my notebook.

Thanks so much.

ps. of course, as usual, i'm ready to test every suggestions/ patches

