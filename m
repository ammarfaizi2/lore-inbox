Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSLZDXP>; Wed, 25 Dec 2002 22:23:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262207AbSLZDXP>; Wed, 25 Dec 2002 22:23:15 -0500
Received: from server.ehost4u.biz ([209.51.155.18]:56020 "EHLO
	host.ehost4u.biz") by vger.kernel.org with ESMTP id <S262067AbSLZDXO>;
	Wed, 25 Dec 2002 22:23:14 -0500
From: "Billy Rose" <billyrose@billyrose.net>
To: user@mail.econolodgetulsa.com
CC: bp@dynastytech.com, linux-kernel@vger.kernel.org
Reply-To: billyrose@billyrose.net
Subject: Re: CPU failures ... or something else ?
X-Mailer: NeoMail 1.25
X-IPAddress: 65.132.64.212
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E18ROk3-000117-00@host.ehost4u.biz>
Date: Wed, 25 Dec 2002 22:31:27 -0500
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.ehost4u.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32076 2072] / [32076 2072]
X-AntiAbuse: Sender Address Domain - host.ehost4u.biz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Oh and by the way, this is a dell poweredge 2450, dual 866 p3 cpus,
> 2gigs ram, and using a PERC 3/D.  I have a 2.4.1 system running on
> _identical_ hardware with no problems, and this system that is
> MCE'ing is a 2.4.16.

try reseating the cpu's and vrm's. if that doesnt work, remove cpu #2
and #2 vrm. run it and see if the error occurs. if no error, #2 cpu or
#2 vrm is bad. if the error still occurs, swap out cpu #1 and #1 vrm
with cpu #2 and #2 vrm, then run again. if the error still occurs,
youre SOL.

billy

=====
"there's some milk in the fridge that's about to go bad...
and there it goes..." -bobby
