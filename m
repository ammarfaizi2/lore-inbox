Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318529AbSHLBAF>; Sun, 11 Aug 2002 21:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318536AbSHLBAE>; Sun, 11 Aug 2002 21:00:04 -0400
Received: from monster.nni.com ([216.107.0.51]:24081 "EHLO admin.nni.com")
	by vger.kernel.org with ESMTP id <S318529AbSHLBAD>;
	Sun, 11 Aug 2002 21:00:03 -0400
Date: Sun, 11 Aug 2002 21:03:14 -0400
From: Andrew Rodland <arodland@noln.com>
To: "Michel Eyckmans (MCE)" <mce@pi.be>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.31: modules don't work at all
Message-Id: <20020811210314.26e9d5a9.arodland@noln.com>
In-Reply-To: <200208111241.g7BCfakl018731@jebril.pi.be>
References: <200208111241.g7BCfakl018731@jebril.pi.be>
X-Mailer: Sylpheed version 0.8.1claws38 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Aug 2002 14:41:36 +0200
"Michel Eyckmans (MCE)" <mce@pi.be> wrote:

> 
> After upgrading from 2.5.30 to 2.5.31, nothing related to modules 
> works for me. Insmod, rmmod, you name it. They all cause errors
> along the line of: "QM_SYMBOLS: Bad Address". Any suggestions?
> 
> This is with the very latest modutils (2.4.19). These work fine 
> with 2.5.30.

Ditto here.
Ryan: Yes, CONFIG_PREEMPT is set.

--hobbs
