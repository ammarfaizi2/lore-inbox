Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWIASlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWIASlK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 14:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWIASlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 14:41:10 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:41963 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1750748AbWIASlI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 14:41:08 -0400
Date: Fri, 1 Sep 2006 20:41:06 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Stephen Hemminger <shemminger@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: sky2 hangs on me again: This time 200 kb/s IPv4 traffic, not easily reproducable
Message-ID: <20060901184106.GI1959@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Stephen Hemminger <shemminger@osdl.org>,
	LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11-2006-07-11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
my sky2 network card in my intel mac mini just stopped working again on
me. After a reboot it worked again. This time there is no dmesg output
related to the problem. :-( Am I the only one who sees that?

        Thomas
