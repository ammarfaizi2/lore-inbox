Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbTAaQNh>; Fri, 31 Jan 2003 11:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbTAaQNh>; Fri, 31 Jan 2003 11:13:37 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:52403 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261593AbTAaQNh> convert rfc822-to-8bit; Fri, 31 Jan 2003 11:13:37 -0500
Content-Type: text/plain;
  charset="iso-8859-2"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Krzysztof =?iso-8859-2?q?Ol=EAdzki?= <ole@ans.pl>
Subject: Re: Default mount options ignored on ext3
Date: Fri, 31 Jan 2003 17:22:27 +0100
User-Agent: KMail/1.4.3
Cc: <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0301311640560.24196-100000@dark.pcgames.pl>
In-Reply-To: <Pine.LNX.4.33.0301311640560.24196-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301311722.27759.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 31 January 2003 16:45, Krzysztof Olêdzki wrote:

Hi Krzysztof,

> Yes. This is true. But if I have to set rootflags= I can't find any reason
> for allowing to change "Default mount options". Kernel ignores it, mount
> ignores it... Hm....
Well, those option is ignored for your ROOT device. Anything else != rootfs 
will work with mount options / fstab.

ciao, Marc


