Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270530AbUJTWhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270530AbUJTWhm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 18:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270563AbUJTWg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 18:36:58 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:8066 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S270488AbUJTWen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 18:34:43 -0400
Subject: Re: [ACPI] Machines self-power-up with 2.6.9-rc3 (evo N620c, ASUS,
	...)
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
In-Reply-To: <20041020191531.GC21315@elf.ucw.cz>
References: <20041020191531.GC21315@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1098311478.4989.100.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 21 Oct 2004 08:31:18 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2004-10-21 at 05:15, Pavel Machek wrote:
> Hi!
> 
> I'm seeing bad problem with N620c notebook (and have reports of more
> machines behaving like this, for example ASUS L8400C.) If I shutdown
> machine with lid closed, opening lid will power the machine up. Ouch.
> 2.6.7 behaves okay.

:> Some people would love to have the machine power up when they open
the lid! Wish my XE3 would do that!

> Ouch, acpi=off makes it even worse [2.6.9-rc3, N620c]. I get some very
> strange show on the leds (battery charge led blinks fast?!), then
> machine powers up itself. This happens even with lid initially
> open. 2.6.7 works as expected.

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Many today claim to be tolerant. True tolerance, however, can cope with others
being intolerant.

