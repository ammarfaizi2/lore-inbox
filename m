Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268636AbRG3WYh>; Mon, 30 Jul 2001 18:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267023AbRG3WY1>; Mon, 30 Jul 2001 18:24:27 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:33543 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S268667AbRG3WYI>; Mon, 30 Jul 2001 18:24:08 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: serial console and kernel 2.4
Date: Mon, 30 Jul 2001 22:24:16 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9k4mqg$1ch$1@ncc1701.cistron.net>
In-Reply-To: <200107301520.f6UFKtT06867@localhost.localdomain> <20010731045527.A5863@weta.f00f.org> <996525392.3352.4.camel@tduffy-lnx.afara.com> <20010731094118.B6318@weta.f00f.org>
X-Trace: ncc1701.cistron.net 996531856 1425 195.64.65.67 (30 Jul 2001 22:24:16 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

In article <20010731094118.B6318@weta.f00f.org>,
Chris Wedgwood  <cw@f00f.org> wrote:
>On Mon, Jul 30, 2001 at 01:36:32PM -0700, Thomas Duffy wrote:
>
>    to what?  and which version is broken?
>
>No idea, whatever debian ships with.
>
>The reason I use debian is 'things just work' --- presumably redhat
>has an update for sysvinit, so just snarf the latest and see if that
>helps.

sysvinit 2.80 is now in debian unstable, it fixes the CREAD bug.
It might take 1 or 2 days for the alpha/mips/etc autobuilders to
catch up and produce a .deb for those platforms.

Mike.
-- 
"dselect has a user interface which scares small children"
	-- Theodore Tso, on debian-devel

