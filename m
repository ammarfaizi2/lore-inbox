Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbTKTToc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 14:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbTKTToc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 14:44:32 -0500
Received: from mail.xor.ch ([212.55.210.163]:28424 "HELO mail.xor.ch")
	by vger.kernel.org with SMTP id S261793AbTKTTo1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 14:44:27 -0500
Message-ID: <3FBD1997.FA66A2F1@orpatec.ch>
Date: Thu, 20 Nov 2003 20:44:22 +0100
From: Otto Wyss <otto.wyss@orpatec.ch>
Reply-To: otto.wyss@orpatec.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: ALSA ICE1724 driver doesn't work
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since google shows no results and nobody in the alsa project knows an
answer I try it here. Just say if there is a better place to ask.

When alsa is started I get the following error:

Starting ALSA (version 0.9.6): ice1724-failed failed

After shutting down X I see on the console the following message:

ALSA ../../alsa-kernel/pci/ice1712/ice1724.c:1614: invalid EEPROM (size=120)

I guess there is something in the kernel driver wrong. How can I fix
this? Is there a newer version?

O. Wyss

-- 
See "http://wxguide.sourceforge.net/" for ideas how to design your app


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-user
