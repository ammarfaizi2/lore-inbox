Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbVDCQB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbVDCQB0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 12:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbVDCQB0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 12:01:26 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:39073 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S261801AbVDCQBY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 12:01:24 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Esben Stien <b0ef@esben-stien.name>
Cc: linux-kernel@vger.kernel.org
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
	<87psxcsq06.fsf@quasar.esben-stien.name>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Esben Stien <b0ef@esben-stien.name>,
	linux-kernel@vger.kernel.org
Date: Sun, 03 Apr 2005 18:01:21 +0200
In-Reply-To: <87psxcsq06.fsf@quasar.esben-stien.name> (Esben Stien's message
	of "Sun, 03 Apr 2005 01:44:25 +0200")
Message-ID: <87u0mn3l4e.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Esben Stien <b0ef@esben-stien.name> writes:

> Jeremy Nickurak <atrus@rifetech.com> writes:
>
>> I'm playing with this under 2.6.11.4 
>
> I got 2.6.12-rc1 
>
>> The vertical cruise control buttons work properly, with the
>> exception of the extra button press.
>
> Yup, nice, I see the same

Same here.

>> But the horizontal buttons are mapping to 6/7 as non-repeat
>> buttons, and adding simulateously the 4/5 events auto-repeated for
>> as long as the button is down. That is to say, pressing the the
>> horizontal scroll in a 2d scrolling area will scroll *diagonally*
>> one step, then vertically until the button is released.
>
> Yup, seeing exactly the same here. 

Horizontal scrolling works fine for me.  I just get repeated 6/7
events, nothing else.

I'm using the configuration described at:
http://blog.blackdown.de/2005/04/03/logitech-mx1000-configuration/


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
