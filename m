Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVDBXrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVDBXrS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 18:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVDBXrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 18:47:17 -0500
Received: from mail48-s.fg.online.no ([148.122.161.48]:2286 "EHLO
	mail48-s.fg.online.no") by vger.kernel.org with ESMTP
	id S261370AbVDBXrG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 18:47:06 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Logitech MX1000 Horizontal Scrolling
References: <873bxfoq7g.fsf@quasar.esben-stien.name>
	<87zmylaenr.fsf@quasar.esben-stien.name>
	<20050204195410.GA5279@ucw.cz>
	<873bvyfsvs.fsf@quasar.esben-stien.name>
	<87zmxil0g8.fsf@quasar.esben-stien.name>
	<1110056942.16541.4.camel@localhost>
	<87sm37vfre.fsf@quasar.esben-stien.name>
	<87wtsjtii6.fsf@quasar.esben-stien.name>
	<20050308205210.GA3986@ucw.cz> <1112083646.12986.3.camel@localhost>
From: Esben Stien <b0ef@esben-stien.name>
X-Home-Page: http://www.esben-stien.name
Date: Sun, 03 Apr 2005 01:44:25 +0200
In-Reply-To: <1112083646.12986.3.camel@localhost> (Jeremy Nickurak's message
 of "Tue, 29 Mar 2005 01:07:26 -0700")
Message-ID: <87psxcsq06.fsf@quasar.esben-stien.name>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Nickurak <atrus@rifetech.com> writes:

> I'm playing with this under 2.6.11.4 

I got 2.6.12-rc1 

> The vertical cruise control buttons work properly, with the
> exception of the extra button press.

Yup, nice, I see the same

> But the horizontal buttons are mapping to 6/7 as non-repeat buttons,
> and adding simulateously the 4/5 events auto-repeated for as long as
> the button is down. That is to say, pressing the the horizontal
> scroll in a 2d scrolling area will scroll *diagonally* one step,
> then vertically until the button is released.

Yup, seeing exactly the same here. 

-- 
Esben Stien is b0ef@esben-stien.name
http://www.esben-stien.name
irc://irc.esben-stien.name/%23contact
[sip|iax]:esben-stien.name
