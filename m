Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261408AbVCGL7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbVCGL7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 06:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261409AbVCGL7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 06:59:06 -0500
Received: from mail43-s.fg.online.no ([148.122.161.43]:23458 "EHLO
	mail43-s.fg.online.no") by vger.kernel.org with ESMTP
	id S261408AbVCGL7D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 06:59:03 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech MX1000 Horizontal Scrolling
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
	<87zmylaenr.fsf@quasar.esben-stien.name>
	<20050204195410.GA5279@ucw.cz>
	<873bvyfsvs.fsf@quasar.esben-stien.name>
	<87zmxil0g8.fsf@quasar.esben-stien.name>
	<1110056942.16541.4.camel@localhost>
From: Esben Stien <b0ef@esben-stien.name>
X-Home-Page: http://www.esben-stien.name
Date: Mon, 07 Mar 2005 12:48:05 +0100
In-Reply-To: <1110056942.16541.4.camel@localhost> (Jeremy Nickurak's message
 of "Sat, 05 Mar 2005 14:09:02 -0700")
Message-ID: <87sm37vfre.fsf@quasar.esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Nickurak <atrus@rifetech.com> writes:

> this is just a result of our different xmodmap configurations.

Yes.

> Otherwise we're seeing exactly the same symptoms.

Hmm, I'm getting the same hash for evdev.c between 2.6.10 and
2.6.11. I hope Vojtech Pavlik got the reports.

Is this reported as a bug?

-- 
Esben Stien is b0ef@esben-stien.name
http://www.esben-stien.name
irc://irc.esben-stien.name/%23contact
[sip|iax]:b0ef@esben-stien.name
