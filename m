Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267849AbUHKAF1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267849AbUHKAF1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 20:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267850AbUHKAEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 20:04:51 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:26382 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S267836AbUHKAE2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 20:04:28 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: suspend2 merge [was Re: [RFC] Fix Device Power Management States]
Date: Wed, 11 Aug 2004 02:04:13 +0200
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net> <1092179384.2711.29.camel@laptop.cunninghams> <20040810233607.GC2287@elf.ucw.cz>
In-Reply-To: <20040810233607.GC2287@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200408110204.13560.arekm@pld-linux.org>
X-Spam-Score: 0.0 (/)
X-Spam-Report: Points assigned by spam scoring system to this email. Note that message
	is treated as spam ONLY if X-Spam-Flag header is set to YES.
	If you have any report questions, see report postmaster@beep.pl for details.
	Content analysis details:   (0.0 points, 25.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 of August 2004 01:36, Pavel Machek wrote:
> Now, people like suspend2 even more, and for good reasons: it is
> extremely fast, it provides nice feedback and its refrigerator is
> superior.
... and it works with modular IDE. It resumes nicely when called from initrd. 
It is modular itself (well, parts of it) - I'm loading suspend modules from 
initrd, too.

pmdisk+swsusp unfortunately wasn't able to do it last time I've checked.

> Best regards,
> 								Pavel

-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
