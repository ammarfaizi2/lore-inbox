Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265677AbTFNPHK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 11:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265680AbTFNPHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 11:07:09 -0400
Received: from www.wwns.com ([209.149.59.66]:61142 "EHLO wwns.wwns.com")
	by vger.kernel.org with ESMTP id S265677AbTFNPHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 11:07:08 -0400
From: "David R. Wilson" <david@wwns.com>
Message-Id: <200306141529.h5EFT4x00815@wwns.wwns.com>
Subject: Linux-2.4.21-rc7 sound glitching with via82cxxx
To: linux-kernel@vger.kernel.org
Date: Sat, 14 Jun 2003 10:29:04 -0500 (CDT)
Cc: mark@justirc.net
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mark,

I see the same behavior with 2.4.21-rc7-ac1 and the cs46xx sound module.
I have tried installing the alsa modules and have also removed them.  I 
don't know where that behavior is coming from.

In the gnome-cd program I see the play time rather randomly jump
forward and back to different places in the audio track.  Audio is 
disrupted for sometimes several seconds for every few bars of the 
recording.

If you run into any information on what is causing this let me know.  I am
not convinced it is a kernel feature... but it is at the very least 
annoying.  It makes listening to CDs impossible.

Dave
-- 
David R. Wilson  WB4LHO
World Wide Network Services
Nashville, Tennessee USA
david@wwns.com

