Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbSLJSXw>; Tue, 10 Dec 2002 13:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbSLJSXw>; Tue, 10 Dec 2002 13:23:52 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:45697 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id <S264659AbSLJSXv>;
	Tue, 10 Dec 2002 13:23:51 -0500
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] IP: disable ECN support by default - Config option
References: <200212100316.59910.m.c.p@wolk-project.de>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 10 Dec 2002 03:53:06 +0100
In-Reply-To: <200212100316.59910.m.c.p@wolk-project.de>
Message-ID: <m3n0ne1t65.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen <m.c.p@wolk-project.de> writes:

> attached super trivial patch gives us a config option to choose whether we 
> want ECN disabled per default if selected or not.

Why do we need that if we can enable/disable ECN at runtime?
-- 
Krzysztof Halasa
Network Administrator
