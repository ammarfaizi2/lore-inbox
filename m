Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129786AbRA0WSz>; Sat, 27 Jan 2001 17:18:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130340AbRA0WSp>; Sat, 27 Jan 2001 17:18:45 -0500
Received: from shell.ca.us.webchat.org ([216.152.64.152]:59100 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S129786AbRA0WSc>; Sat, 27 Jan 2001 17:18:32 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "Gregory Maxwell" <greg@linuxpower.cx>,
        "Jamie Lokier" <lk@tantalophile.demon.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: hotmail not dealing with ECN
Date: Sat, 27 Jan 2001 14:18:31 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKCECMNFAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <20010127151428.H6821@xi.linuxpower.cx>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Firewalling should be implemented on the hosts, perhaps with centralized
> policy management. In such a situation, there would be no reason to filter
> on funny IP options.

	That's madness. If you have to implement your firewalling on every host,
what do you do when someone wants to run a new OS? Forbid it?

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
