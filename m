Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262083AbVADK4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262083AbVADK4V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 05:56:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVADK4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 05:56:21 -0500
Received: from mail1.kontent.de ([81.88.34.36]:6082 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262067AbVADK4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 05:56:09 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Swsusp hanging the second time
Date: Tue, 4 Jan 2005 11:54:19 +0100
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200501041154.19030.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there's a second, more serious problem with this laptop. It hangs the
in the second swsusp cycle on suspension.
As before 2.6.10, i386/UP/no highmem.
On the screen I get the two messages "radeonfb resumed!" and
"setting latency" superimposed and it hangs forever. This is a regression
the previous user commented: "It worked under 2.6.6"

	Regards
		Oliver
