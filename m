Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWGPX1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWGPX1v (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 19:27:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWGPX1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 19:27:51 -0400
Received: from khc.piap.pl ([195.187.100.11]:39831 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751335AbWGPX1v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 19:27:51 -0400
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.17.3 kernel panic
References: <m3psg5a5lp.fsf@defiant.localdomain>
	<6bffcb0e0607160926h25ae8171kf2785f731a62fb6b@mail.gmail.com>
	<m3lkqta4h9.fsf@defiant.localdomain>
	<6bffcb0e0607160949j7b38c98ci323c62d9b35e469a@mail.gmail.com>
	<m3odvpbblv.fsf@defiant.localdomain>
	<6bffcb0e0607161427x5146caa9v3b11752a6d2bb20d@mail.gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 17 Jul 2006 01:27:48 +0200
In-Reply-To: <6bffcb0e0607161427x5146caa9v3b11752a6d2bb20d@mail.gmail.com> (Michal Piotrowski's message of "Sun, 16 Jul 2006 23:27:24 +0200")
Message-ID: <m3y7utuo3v.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> writes:

>> Both that and memtest86, several times. Will run it again, though.
>
> So if you don't have any bad blacks...

None if you mean HDD. memtest86+ from FC5 boot disk haven't found
anything wrong with RAM, either.

> this it similar to my bug
> report http://www.ussg.iu.edu/hypermail/linux/kernel/0606.3/index.html#2558

Not very, actually. Looks it's time to give this machine some
real exercise. The problem is it's random.
-- 
Krzysztof Halasa
