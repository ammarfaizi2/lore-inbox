Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbUDACIV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 21:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261925AbUDACIU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 21:08:20 -0500
Received: from smtp.futureway.com ([64.119.104.8]:43574 "HELO
	smtp.futureway.com") by vger.kernel.org with SMTP id S261920AbUDACIT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 21:08:19 -0500
From: "Anthony Rosati (NSI)" <anthony@1100101.net>
Organization: Nanite Services Inc
To: linux-kernel@vger.kernel.org
Subject: re. kernel 2.6.5-rc3
Date: Wed, 31 Mar 2004 21:08:21 -0500
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403312108.22016.anthony@1100101.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying 2.6.5-rc3 on a Centrino 1.30GHz notebook, 512MB DDR. 
Slackware sid userspace. Kernel built with most laptop features. Kernel 
2.6.5-rc1 and rc2 had no issues.

After boot things are fine for a while, then without any visible diagnostic
output, the machine gets very slow. Running top shows that events/0 is
consuming the CPU. (94%) and no way to stop process/.

Suggests for where to look or what to try? How do i stop the pid?

--
radius

***********************************************************************************
This communication is intended for the use of the recipient to which it is 
addressed, and may contain confidential, personal, and or privileged 
information. Please contact the sender immediately if you are not the
intended recipient of this communication, and do not copy, distribute,
or take action relying on it. Any communication received in error, or
subsequent reply, should be deleted or destroyed.
***********************************************************************************
