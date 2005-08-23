Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932178AbVHWOII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbVHWOII (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 10:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbVHWOIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 10:08:07 -0400
Received: from seneca.an-computer.de ([217.172.186.23]:488 "EHLO
	seneca.an-computer.de") by vger.kernel.org with ESMTP
	id S932178AbVHWOIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 10:08:06 -0400
Message-ID: <1124806076.430b2dbcdd259@ssl.an-computer.de>
Date: Tue, 23 Aug 2005 16:07:56 +0200
From: Daniel Nofftz <daniel@nofftz.net>
To: linux-kernel@vger.kernel.org
Subject: another Followup on 2.6.13-rc3 ACPI processor C-state regression
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.6
X-Originating-IP: 217.6.95.140
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: daniel@nofftz.net
X-SA-Exim-Scanned: No (on seneca.an-computer.de); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(It looks like my first try to send this message as a reply to the "Followup
..." didn't work. If it worked: sorry for double-post)

I use 2.6.13-rc6-mm1 which includes the patch as far as i can see, but
the C2 idle state (which my processor definetly supports) isn't
detected . it also isn't detected with 2.6.13-rc6 or 2.6.12.5 . but it definetly
worked with some older 2.6.x kernel.

is there any way to enforce using c2 ? so that you could say that the
acpi system uses c2 even if it is unable to detect that it is supported
?

daniel
(please CC me, cause i am not on the list at the moment)

-- 
# Daniel Nofftz .................................................. #


----------------------------------------------------------------
This message was sent using IMP, the Internet Messaging Program.
