Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275897AbTHOKNt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275899AbTHOKNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:13:49 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:49125 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S275897AbTHOKNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 06:13:23 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Fri, 15 Aug 2003 12:13:21 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Oleg Drokin <green@namesys.com>
Cc: marcelo@conectiva.com.br, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org, mason@suse.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030815121321.49e4cf09.skraw@ithnet.com>
In-Reply-To: <20030814084518.GA5454@namesys.com>
References: <20030813125509.360c58fb.skraw@ithnet.com>
	<Pine.LNX.4.44.0308131143570.4279-100000@localhost.localdomain>
	<20030813145940.GC26998@namesys.com>
	<20030813171224.2a13b97f.skraw@ithnet.com>
	<20030813153009.GA27209@namesys.com>
	<20030814084518.GA5454@namesys.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Oleg,

there was a question about fsck'ing the ext3 filesystems. Since it crashed
today I did check them now and no errors or warnings showed up. Everything
seems clean. I don't exactly understand what that tells you. I guess you mean
the fs metadata may have been hit, too. Seems not.

Regards,
Stephan
