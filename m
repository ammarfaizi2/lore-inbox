Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277038AbRJQSjO>; Wed, 17 Oct 2001 14:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277046AbRJQSjE>; Wed, 17 Oct 2001 14:39:04 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:12563 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277038AbRJQSit>;
	Wed, 17 Oct 2001 14:38:49 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110171839.WAA22514@ms2.inr.ac.ru>
Subject: Re: [NFS] NFSD over TCP: TCP broken?
To: kalele@veritas.com (Shirish Kalele)
Date: Wed, 17 Oct 2001 22:39:08 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org, tamir@veritas.com, paulp@veritas.com
In-Reply-To: <005a01c1579d$adab2100$3291b40a@fserv2000.net> from "Shirish Kalele" at Oct 17, 1 11:25:27 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I'm making nfsd do blocking writes.

I see. Well, then you should make this right. :-)


> send(3N) manpage on Linux also says messages should be sent atomically.

Sorry? Please, cite, I cannot find this. send() behaviour used to be
pretty different. :-)

Alexey
