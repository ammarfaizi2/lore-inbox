Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129757AbQLTLeA>; Wed, 20 Dec 2000 06:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbQLTLdu>; Wed, 20 Dec 2000 06:33:50 -0500
Received: from quechua.inka.de ([212.227.14.2]:26745 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S129757AbQLTLdg>;
	Wed, 20 Dec 2000 06:33:36 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP kernel modification
In-Reply-To: <20001220055636.7325.qmail@web4605.mail.yahoo.com>
Organization: private Linux site, southern Germany
Date: Wed, 20 Dec 2000 11:52:47 +0100
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E148gra-0002uw-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i.e after the kernel calls ip_route_output() and
> ip_route_output_slow() and fails to find a match, i
> need the kernel to somehow "hook-up" with a
> process/daemon(routing protocol) and access a user
> route cache there.

You may try this: <URL:http://sites.inka.de/~bigred/sw/rrouted.txt>

Olaf
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
