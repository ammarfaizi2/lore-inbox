Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136942AbREJVYy>; Thu, 10 May 2001 17:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136944AbREJVYo>; Thu, 10 May 2001 17:24:44 -0400
Received: from dewey.mindlink.net ([204.174.16.4]:13068 "EHLO
	dewey.paralynx.net") by vger.kernel.org with ESMTP
	id <S136942AbREJVYj>; Thu, 10 May 2001 17:24:39 -0400
Subject: Alpha SMP/Network performance problem with vanilla 2.4.4
From: Jay Thorne <Yohimbe@userfriendly.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 10 May 2001 14:24:37 -0700
Message-Id: <989529877.7411.2.camel@gracie.userfriendly.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a problem on alpha SMP on the
AS4100 (Rawhide) machine. Under SMP, with heavy network activity.
With an inbound and outbound ping flood running, after about 500,000
packets, it just dies. Console dead, no response. For about a minute.
Then, sometimes, the machine comes back. 
Anything I can instrument? to help?
Alt-sysrq, though enabled, does not seem to work on these machine's
consoles.

--
Jay Thorne Manager, Systems & Technology, UserFriendly Media, Inc.

