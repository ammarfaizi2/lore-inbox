Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264426AbTLBX3d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264439AbTLBX3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:29:33 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:60424 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S264426AbTLBX3c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:29:32 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: libata in 2.4.24?
Date: 2 Dec 2003 23:18:24 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bqj6k0$e2p$1@gatekeeper.tmr.com>
References: <3FCB8312.3050703@rackable.com> <877k1f9e1g.fsf@stark.dyndns.tv> <bqj41c$drr$1@gatekeeper.tmr.com> <20031202230216.GB4154@mis-mike-wstn.matchmail.com>
X-Trace: gatekeeper.tmr.com 1070407104 14425 192.168.12.62 (2 Dec 2003 23:18:24 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031202230216.GB4154@mis-mike-wstn.matchmail.com>,
Mike Fedyk  <mfedyk@matchmail.com> wrote:
| On Tue, Dec 02, 2003 at 10:34:20PM +0000, Bill Davidsen wrote:
| > after each O_SYNC write, so that's probably not practical. Clearly the
| > best solution is a full SCSI implementation over PATA/SATA, but that
| > would eliminate some of the justification for SCSI devices at premium
| > prices.
| 
| In many ways, that is exactly what SATA is. :)

Until multiple devices be string are available SATA will have logistical
problems scaling. The small cable is an advantage running a few drives
in a box, but a server with 40 drives or so would go from a cable bundle
out the back, about 5cm by 1 cm, to a real bunch of those little round
cables running everywhere. Certainly doable, but I think I'd name the
server "Medusa" if I built it.

I believe SATA-2 will address this, if I may believe what's projected
for an unwritten standard.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
