Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264706AbTE1MiU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 08:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264707AbTE1MiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 08:38:19 -0400
Received: from gherkin.frus.com ([192.158.254.49]:640 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S264706AbTE1MiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 08:38:19 -0400
Subject: 2.5.70: still no boot logo
To: linux-kernel@vger.kernel.org
Date: Wed, 28 May 2003 07:51:33 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030528125133.6C3C64F11@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, it's minor compared to what *could* be (and probably is) broken.
I've got "CONFIG_LOGO=y" and "CONFIG_LOGO_LINUX_CLUT224=y" with VESA
framebuffer -- the same setup I've used successfully for many moons.

On the positive side, whatever broke in the 2.5.6X series that affected
my DHCP server has been fixed: my HP network printer thanks you :-).
Overall, 2.5.70 seems to be working fine for me other than the minor
matter of the logo at boot time.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
