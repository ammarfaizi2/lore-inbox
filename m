Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265098AbSLMQeZ>; Fri, 13 Dec 2002 11:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265099AbSLMQeZ>; Fri, 13 Dec 2002 11:34:25 -0500
Received: from mailhost.bonet.ac ([194.165.224.191]:55797 "EHLO
	mailhost.bonet.ac") by vger.kernel.org with ESMTP
	id <S265098AbSLMQeZ>; Fri, 13 Dec 2002 11:34:25 -0500
From: "Alfred M. Szmidt" <ams@kemisten.nu>
To: root@chaos.analogic.com
CC: andrew@walrond.org, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
In-reply-to: <Pine.LNX.3.95.1021213101227.2190A-100000@chaos.analogic.com>
	(root@chaos.analogic.com)
Subject: Re: Symlink indirection
References: <Pine.LNX.3.95.1021213101227.2190A-100000@chaos.analogic.com>
Message-Id: <E18Mssn-0007aV-00@lgh163a.kemisten.nu>
Date: Fri, 13 Dec 2002 17:41:49 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   This should be defined as "PATH_MAX".

This should only be defined if such an limit exists.  Systems like
GNU/Hurd do not have this limit, but GNU/Linux does.
