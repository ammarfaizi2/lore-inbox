Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266683AbUF3O2s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266683AbUF3O2s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 10:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266682AbUF3O2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 10:28:48 -0400
Received: from 80-169-17-66.mesanetworks.net ([66.17.169.80]:24246 "EHLO
	mail.bounceswoosh.org") by vger.kernel.org with ESMTP
	id S266683AbUF3O2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 10:28:46 -0400
Date: Wed, 30 Jun 2004 08:33:03 -0600
From: "Eric D. Mudama" <edmudama@bounceswoosh.org>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: "Eric D. Mudama" <edmudama@bounceswoosh.org>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: Silicon Image 3512 & seagate ST3120026AS in 2.4.27-rc2
Message-ID: <20040630143303.GA32765@bounceswoosh.org>
Mail-Followup-To: Ricky Beam <jfbeam@bluetronic.net>,
	Linux Kernel Mail List <linux-kernel@vger.kernel.org>
References: <20040629161109.GA24220@bounceswoosh.org> <Pine.GSO.4.33.0406291354410.25702-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.33.0406291354410.25702-100000@sweetums.bluetronic.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29 at 13:59, Ricky Beam wrote:
>Maxtor has a perminant entry on my shitlist following their 60% failure
>rate with their SATA drives (in bulk.)  And seeing how Dell no longer
>builds systems with Maxtor drives adds weight to my listing :-) (Unless
>they are getting a damn good OEM deal from WD, I don't think cost was why
>they switched.  Even Tivo switched to WD after the Maxtor/Quantum merge.)

There's always a group of people who have shitlisted brand X due to
the way something failed, this is especially common in disk drives.

I'm sorry you had the problems, but they're not indicitive of Maxtor
as a whole, or we wouldn't be in business at all.  I'm not sure how
our account with Tivo looks, but last I heard we were still the #1
supplier of drives into settop boxes.

I do think our new MaxLine III is a pretty hot drive, and it supports
NCQ, (with big performance gains in server-type applications) so as
soon as Jeff can get the ahci driver into the kernel...

--eric

PS: If you have issues in the future, feel free to contact me at
work... firstname_lastname@maxtor.com, and I'll do what I can to try
to help.


-- 
Eric D. Mudama
edmudama@mail.bounceswoosh.org

