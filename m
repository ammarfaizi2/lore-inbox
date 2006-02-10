Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWBJR6s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWBJR6s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 12:58:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751358AbWBJR6s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 12:58:48 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:11418 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1751289AbWBJR6r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 12:58:47 -0500
Date: Fri, 10 Feb 2006 18:58:48 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: linux-kernel@vger.kernel.org
Subject: CD-blanking leads to machine freeze with current -git [was: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux (stirring up a hornets' nest) ]]
Message-ID: <20060210175848.GA5533@stiffy.osknowledge.org>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc2-marc-g5bc159e6-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Bartlomiej Zolnierkiewicz <bzolnier@gmail.com> [2006-01-27 17:37:48 +0100]:

> Hi,
> 
> I'm stealing thread <...>

... me, too.

> I address this to everybody not only to Joerg:

... me, too.

I just tried blanking a CD-RW with the latest -git tree. The machine just became
unresponsive and then froze. When it became unresponsive the clock in GNOME still
displayed the current time but I could not focus any windows anymore. Then I had
to hard reboot the machine. The logs say nothing. I repeat: nothing.

Does anyone have similar problems?

Marc
