Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263524AbTDTEiV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 00:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTDTEiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 00:38:21 -0400
Received: from ohsmtp03.ogw.rr.com ([65.24.7.38]:49829 "EHLO
	ohsmtp03.ogw.rr.com") by vger.kernel.org with ESMTP id S263524AbTDTEiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 00:38:21 -0400
Message-ID: <000701c306f6$cf100180$0200a8c0@satellite>
From: "Dave Mehler" <dmehler26@woh.rr.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.5.68 kernel no initrd
Date: Sun, 20 Apr 2003 00:39:19 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
    Ok, i should learn to leave well enough alone, but i don't. After
successfully installing a monolithic 2.5.67 kernel i decided i wanted
modules, so i made them, and what happened, it hung after the initrd
initialized. So, when 2.5.68 came out i of course grab it, compile/install
it without a hitch, but for one thing, as of now make install did not make
an initrd for that install. Does anyone know how to make this manually, it
won't boot without one?
Thanks.
Dave.

