Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263118AbTDWQLQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264101AbTDWQLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:11:16 -0400
Received: from franka.aracnet.com ([216.99.193.44]:20633 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263118AbTDWQLP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:11:15 -0400
Date: Wed, 23 Apr 2003 09:23:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 623] New: Volume not remembered.
Message-ID: <21660000.1051114998@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=623

           Summary: Volume not remembered.
    Kernel Version: 2.5.x
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: pat@suwalski.net


Distribution: Gentoo
Hardware Environment: ALSA, 82801AA AC'97 Audio
Software Environment: Gnome
Problem Description:
Not certain if this is kernel or ALSA specific. In 2.4.x OSS volume levels
were remembered for the various mixers. Now all of them always default to 0
at bootup. I never ran ALSA with the 2.4 series, but it would be nice to
remember volumes.
Should I be bugging the alsa-project people instead?

Steps to reproduce:
Set a volume level, reboot, level has been reset.

