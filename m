Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSLZDzV>; Wed, 25 Dec 2002 22:55:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSLZDzV>; Wed, 25 Dec 2002 22:55:21 -0500
Received: from server.ehost4u.biz ([209.51.155.18]:5335 "EHLO host.ehost4u.biz")
	by vger.kernel.org with ESMTP id <S262208AbSLZDzU>;
	Wed, 25 Dec 2002 22:55:20 -0500
From: "Billy Rose" <billyrose@billyrose.net>
To: user@mail.econolodgetulsa.com
CC: bp@dynastytech.com, linux-kernel@vger.kernel.org, felipewd@terra.com.br
Reply-To: billyrose@billyrose.net
Subject: Re: CPU failures ... or something else ?
X-Mailer: NeoMail 1.25
X-IPAddress: 65.132.64.212
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E18RPFA-0001ci-00@host.ehost4u.biz>
Date: Wed, 25 Dec 2002 23:03:36 -0500
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.ehost4u.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32076 2072] / [32076 2072]
X-AntiAbuse: Sender Address Domain - host.ehost4u.biz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i agree with felipe, sounds like either a stick of ram is bad, or proc
#1 is fried (possibly its vrm though).

a DRAC is the dell remote assistant card. it sits in a pci slot, has
an intel i860 proc on it, and has a 10/100 for a net cable. if you
have no cards, then it is obviously ruled out.

billy
=====
"there's some milk in the fridge that's about to go bad...
and there it goes..." -bobby
