Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265748AbUADQKf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 11:10:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265753AbUADQKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 11:10:32 -0500
Received: from hauptpostamt.charite.de ([193.175.66.220]:55481 "EHLO
	hauptpostamt.charite.de") by vger.kernel.org with ESMTP
	id S265748AbUADQJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 11:09:57 -0500
Date: Sun, 4 Jan 2004 17:09:54 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: ALSA error?
Message-ID: <20040104160954.GE27197@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From my log:

Jan  4 16:20:11 hummus kernel: ALSA sound/core/pcm_lib.c:155: Unexpected hw_pointer value (stream = 0, delta: -4095, max jitter = 8192): wrong interrupt acknowledge?

This is 2.6.1-rc1-bk4 with a :
ALSA sound/isa/cs423x/cs4231_lib.c:1056: cs4231: port = 0x534, id = 0xa
pnp: the driver 'opl3sa2' has been registered

Should I worry?

-- 
Ralf Hildebrandt (Im Auftrag des Referat V a)   Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-916
Referat V a - Kommunikationsnetze -             AIM.  ralfpostfix
