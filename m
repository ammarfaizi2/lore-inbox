Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030257AbWGTT1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbWGTT1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 15:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWGTT1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 15:27:16 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:60644 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S964863AbWGTT1Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 15:27:16 -0400
Message-ID: <44BFD911.70106@cmu.edu>
Date: Thu, 20 Jul 2006 15:27:13 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: thinkpad x60s: middle button doesn't work after hibernate
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey guys,

I recently got the suspend to disk working and suspend to memory working
thanks to many of you.  Whenever I suspend to disk and resume, the
middle mouse button on my thinkpad x60s no longer works for scrolling or
for pasting.  I either have to reboot, or suspend to memory and resume.
 Therefore:

Initial Boot: working
Suspend to disk -> resume: not working
Suspend to memory -> resume: working

To fix it for now, i simply suspend to memory and resume after resuming
a suspend to disk.

Anyone else experience this?

Thanks!
George
