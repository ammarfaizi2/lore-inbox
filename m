Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267190AbSK3AUM>; Fri, 29 Nov 2002 19:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267191AbSK3AUM>; Fri, 29 Nov 2002 19:20:12 -0500
Received: from server.ehost4u.biz ([209.51.155.18]:46784 "EHLO
	host.ehost4u.biz") by vger.kernel.org with ESMTP id <S267190AbSK3AUL>;
	Fri, 29 Nov 2002 19:20:11 -0500
From: "Billy Rose" <billyrose@billyrose.net>
To: linux-kernel@vger.kernel.org
CC: cisos@bigpond.net.au
Reply-To: billyrose@billyrose.net
Subject: RE: kernel module and user space functions
X-Mailer: NeoMail 1.25
X-IPAddress: 65.132.64.26
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <E18HvTs-0002D4-00@host.ehost4u.biz>
Date: Fri, 29 Nov 2002 19:27:36 -0500
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - host.ehost4u.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [32076 2072] / [32076 2072]
X-AntiAbuse: Sender Address Domain - host.ehost4u.biz
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> How can I get a kernel module to use functions within an executable,
> please reply with example?

Check this out...

http://people.redhat.com/mingo/TUX-patches/tux-2.2.7.tar.gz

