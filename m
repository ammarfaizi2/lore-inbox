Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268955AbTBSQQB>; Wed, 19 Feb 2003 11:16:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268957AbTBSQQA>; Wed, 19 Feb 2003 11:16:00 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:22715 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S268955AbTBSQP7> convert rfc822-to-8bit; Wed, 19 Feb 2003 11:15:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: [PATCH 2.4.21-pre4|BK] remove /proc/meminfo:MemShared
Date: Wed, 19 Feb 2003 14:03:25 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
References: <200302191333.43875.m.c.p@wolk-project.de> <20030219130008.GD531@fs.tum.de>
In-Reply-To: <20030219130008.GD531@fs.tum.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302191402.09004.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 February 2003 14:00, Adrian Bunk wrote:

Hi Adrian,

> I don't think it's good to do this change in a stable kernel series. The
> entry doesn't do any harm and there might be programs that parse
> /proc/meminfo and expect MemShared to be present.
well, I am not aware of any program that needs MemShared.

This is also in my WOLK tree for a long time (even longer than it was in 2.5) 
and no one out there complained about it yet :)

ciao, Marc


