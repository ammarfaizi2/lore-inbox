Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266590AbTGOHY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 03:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266597AbTGOHY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 03:24:57 -0400
Received: from mail2.zrz.TU-Berlin.DE ([130.149.4.14]:20916 "EHLO
	mail2.zrz.tu-berlin.de") by vger.kernel.org with ESMTP
	id S266590AbTGOHY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 03:24:56 -0400
Message-ID: <4299.194.175.125.228.1058254785.squirrel@mailbox.TU-Berlin.DE>
Date: Tue, 15 Jul 2003 09:39:45 +0200 (CEST)
Subject: Inspiron 8000 makes high pitch noise only with 2.6.0-test1
From: <Daniel.Dorau@alumni.TU-Berlin.DE>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
yesterday I tried the 2.6.0-test1 kernel for the first time.
Installation went flawlessly. However I noticed a high pitch
noise from my notebook everytime after the ethernet driver
was loaded, no matter which one (eepro100 or e100).
It is exactly the noise that my notebook only did with 2.4
when _actually_ transmitting data on IRDA.
I have no clue whatsoever how the same noise is being triggered
by the 2.6 kernel. Disabling IRDA (kernel+BIOS) didn't help.
Since that noise is somewhat nerving, I would be very happy
if someone has an idea how to fix that.
This noise does definitely not appear on 2.4 kernel except when
IRDA is active. On 2.6 I can hear it all the time one the
ethernet driver is loaded. It is only interrupted by heavy disc
activity.
Does anybody has an idea?

Please CC me on reply.

Thank you
Daniel




