Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275420AbRIZSLV>; Wed, 26 Sep 2001 14:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275418AbRIZSLL>; Wed, 26 Sep 2001 14:11:11 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:17413 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S275416AbRIZSK7>; Wed, 26 Sep 2001 14:10:59 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: login vs. portmap revisited
Date: Wed, 26 Sep 2001 18:11:21 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9ot5o9$uuk$4@ncc1701.cistron.net>
In-Reply-To: <20010926131931.D5832@emma1.emma.line.org>
X-Trace: ncc1701.cistron.net 1001527881 31700 195.64.65.67 (26 Sep 2001 18:11:21 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010926131931.D5832@emma1.emma.line.org>,
Matthias Andree  <matthias.andree@stud.uni-dortmund.de> wrote:
>I recently dug through the mail archives to figure why my login requires
>portmap. It seems that poll or recvfrom return semantics  have changed
>from 2.2 to 2.4, and some login or PAM didn't track the change.

It's probably NIS.

>Does anyone have details on this? Whom do I ask for updates? PAM guys?
>glibc guys? "login" maintainer?

Yep, all those, but NOT the kernel development mailinglist.

Mike.
-- 
"I think...I think it's in my basement. Let me go upstairs and check."
	-- M.C. Escher (1898-1972)

