Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTLBJRQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 04:17:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbTLBJRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 04:17:16 -0500
Received: from mail.design-d.info ([62.225.14.106]:25861 "EHLO mail.tammen.de")
	by vger.kernel.org with ESMTP id S261670AbTLBJRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 04:17:15 -0500
From: Heinz Ulrich Stille <hus@design-d.de>
Organization: design_d gmbh
To: linux-kernel@vger.kernel.org
Subject: emu10k1 under kernel 2.6?
Date: Tue, 2 Dec 2003 10:17:07 +0100
User-Agent: KMail/1.5.93
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Message-Id: <200312021017.07936.hus@design-d.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I feel I must be missing something obvious, but I just can't get the SB
Live to work with a 2.6 kernel. The module snd-emu10k1 depends on
snd-ac97-codec, which doesn't load and says:

ALSA sound/pci/ac97/ac97_codec.c:1671: AC'97 0:0 does not respond - RESET
EMU10K1_Audigy: probe of 0000:02:06.0 failed with error -6

It's working just fine with kernel 2.4. What's wrong now?

MfG, Ulrich

-- 
Heinz Ulrich Stille / Tel.: +49-541-9400463 / Fax: +49-541-9400450
design_d gmbh / Lortzingstr. 2 / 49074 Osnabrück / www.design-d.de
