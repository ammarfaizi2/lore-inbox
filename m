Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUDWM1R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUDWM1R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 08:27:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264797AbUDWM1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 08:27:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:42880 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264795AbUDWM1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 08:27:07 -0400
Date: Fri, 23 Apr 2004 08:29:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Andrew McGregor <andrew@indranet.co.nz>
cc: Guennadi Liakhovetski <gl@dsa-ac.de>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       linux-kernel@vger.kernel.org
Subject: Re: [somewhat OT] binary modules agaaaain
In-Reply-To: <5137757.1082762917@[192.168.1.249]>
Message-ID: <Pine.LNX.4.53.0404230812190.2732@chaos>
References: <Pine.LNX.4.33.0404201705510.1869-100000@pcgl.dsa-ac.de>
 <5137757.1082762917@[192.168.1.249]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Apr 2004, Andrew McGregor wrote:

> And it must, if only because there are laws that require some device
> drivers to be binary only.


WRONG.  I work in the industry. There are no such rule(s). In fact,
it's quite the opposite. Anything that is FCC Type Accepted or
Type Approved has, as a matter of law, its complete design
information, to the extent required for FCC Type Acceptance,
available for public inspection in the Public Reference Room.
Therefore, it can't be hidden as something "proprietary".

>
> I kid you not, take a look at the FCC software radio rules.  Some wireless
> cards fall into their definition.
>

The requirement that the devices "not be modified" has been interpreted
by some to mean that software can't be supplied to the end-user. This
is an interpretation and, in fact, an invalid one.

If a user were to modify the device, (presumably by changing the
software) it is no longer Type Approved in the case of receivers,
and, if a transmitter the modification must be done in accordance
with "good standards of engineering practice" under the authority
of a holder of a General Radiotelephone (or Radiotelegraph) License.

The operation of a receiver that is not "Type Approved" is not
unlawful unless it produces "harmful interference". Type Approval
was necessary to SELL a device that generates radio frequency
energy, not to use it.

FYI Amateur Radio Operators make receivers and transmitters. They
are not Type Approved. Holders of FCC Radiotelephone licenses are
allowed to make or modify even 50,000 watt broadcast transmitters.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5557.45 BogoMips).
            Note 96.31% of all statistics are fiction.


