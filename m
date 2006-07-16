Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751338AbWGPXmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751338AbWGPXmi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 19:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWGPXmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 19:42:38 -0400
Received: from alpha.polcom.net ([83.143.162.52]:36811 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S1751338AbWGPXmi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 19:42:38 -0400
Date: Mon, 17 Jul 2006 01:42:30 +0200 (CEST)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17.3 kernel panic
In-Reply-To: <m3y7utuo3v.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.63.0607170134300.10427@alpha.polcom.net>
References: <m3psg5a5lp.fsf@defiant.localdomain>
 <6bffcb0e0607160926h25ae8171kf2785f731a62fb6b@mail.gmail.com>
 <m3lkqta4h9.fsf@defiant.localdomain> <6bffcb0e0607160949j7b38c98ci323c62d9b35e469a@mail.gmail.com>
 <m3odvpbblv.fsf@defiant.localdomain> <6bffcb0e0607161427x5146caa9v3b11752a6d2bb20d@mail.gmail.com>
 <m3y7utuo3v.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2006, Krzysztof Halasa wrote:
> None if you mean HDD. memtest86+ from FC5 boot disk haven't found
> anything wrong with RAM, either.
>
>> this it similar to my bug
>> report http://www.ussg.iu.edu/hypermail/linux/kernel/0606.3/index.html#2558
>
> Not very, actually. Looks it's time to give this machine some
> real exercise. The problem is it's random.

Have you tried prime (from GIMPS) on this machine? It can detect errors on 
systems that have no apparent or visible problems and memtest does not 
show anything bad. It suprised me several times showing problems on 
machines that I could swear were ok.

But maybe it is not hardware fault at all...


Grzegorz Kulewski


PS. Greetings to pm.waw.pl admin! :-)

