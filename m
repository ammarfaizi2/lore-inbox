Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316928AbSGNQvK>; Sun, 14 Jul 2002 12:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316933AbSGNQvJ>; Sun, 14 Jul 2002 12:51:09 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:51217 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316928AbSGNQvI>; Sun, 14 Jul 2002 12:51:08 -0400
Date: Sun, 14 Jul 2002 18:53:57 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Jerry McBride <mcbrides9@comcast.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: missing include...
Message-ID: <20020714165357.GA12015@louise.pinerecords.com>
References: <20020714120440.6b7eb93b.mcbrides9@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020714120440.6b7eb93b.mcbrides9@comcast.net>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.19-pre10/sparc SMP
X-Uptime: 40 days, 8:44
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In compiling 2.4.18 I find that this include is missing from the source...
> linux-2.4.18/include/linux/version.h

It is not. You have just failed to follow the kernel build instructions:
See /usr/src/linux/README.

T.
