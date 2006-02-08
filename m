Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030370AbWBHNAw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030370AbWBHNAw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Feb 2006 08:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWBHNAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Feb 2006 08:00:52 -0500
Received: from mx.laposte.net ([81.255.54.11]:61292 "EHLO mx.laposte.net")
	by vger.kernel.org with ESMTP id S1030370AbWBHNAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Feb 2006 08:00:51 -0500
Message-ID: <52896.192.54.193.35.1139403637.squirrel@rousalka.dyndns.org>
Date: Wed, 8 Feb 2006 14:00:37 +0100 (CET)
Subject: 
From: "Nicolas Mailhot" <nicolas.mailhot@laposte.net>
To: linux-kernel@vger.kernel.org
Cc: bernd@firmix.at
User-Agent: SquirrelMail/1.4.6 [CVS]-0.cvs20060118.1.fc5.1.nim
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >server space, compromising hasn't obviously been a bad strategy, with
> >many SCSI and FC controller manufacturers deciding on their own to
> >work with the Linux kernel development community.  (Sometimes with
> >some help from major system vendors who write in a requirement for a
                  ^^^^^^^^^^^^^^^^^^^^
>Do you knwo the contracts, agreements and result of meetings of major of
>major system vendors with the sales army of big OS corporations in the
>desktop area?
>Probably not.

Right now all the big desktop deployments reuse hardware that was specced
for windows. And they often occur in administrations where hardware has a
long life, and suppliers change only every few years.

You don't need transcendental powers to guess what requirements the city
of Munich, the French Gendarmerie or any of the other big desktop FOSS
users will impose on their suppliers in the next years. Server-space
vendors like IBM HP or Dell know the music because they already walked
through the process for their servers :

1. initial stage: early adopters, (re)use windows hardware, don't ask for
much. Just putting "Linux" in your brochures may tip purchases. Hardware
vendors sometimes are not even informed systems will be deployed using
Linux.

2. stage 2: customers ask for minimal support for the particular Linux
Brand/Version they use, binary modules are deemed acceptable

3. stage 3: vendors notice support costs for binary modules are high, that
customers always ask for some other Linux variant. Customers notice they
spend their time escalading binary module problems, that upgrades plans
are frozen because of them. Vendors that still stick to external binary
drivers loose market share at the moment the market starts to grow big
time.

Right now IMHO desktop Linux passed stage one, is firmly in stage two and
verging  on stage three in some market segments (knowledge
worker/administration workstations). A lot of organisations do not impose
specific Linux requirements on hardware purchases yet because PHBs feel
that would commit them to Linux, but it doesn't mean their IT deps are not
thinking about it.

Regards,

-- 
Nicolas Mailhot

