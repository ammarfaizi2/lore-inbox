Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317777AbSFSF0t>; Wed, 19 Jun 2002 01:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317778AbSFSF0s>; Wed, 19 Jun 2002 01:26:48 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:9477 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S317777AbSFSF0s>; Wed, 19 Jun 2002 01:26:48 -0400
Message-Id: <200206190523.g5J5NQL11213@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Daniel Jacobowitz <dan@debian.org>, linux-kernel@vger.kernel.org
Subject: Re: System halted - or is it?  (2.4.19-pre10-ac2)
Date: Wed, 19 Jun 2002 08:23:59 -0200
X-Mailer: KMail [version 1.3.2]
References: <20020618154816.GA20823@nevyn.them.org>
In-Reply-To: <20020618154816.GA20823@nevyn.them.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 June 2002 13:48, Daniel Jacobowitz wrote:
> I'm using 2.4.19-pre10-ac2 on both my desktop and laptop now.  It works
> great, with one "interesting" exception: on halt, it first stops the RAID
> on my desktop (lots of messages about invalidating busy buffers here), then
> flushes all IDE devices, and then prints System Halted... and then gives me
> back my shell prompt.  The system appears to still work, at least for
> trivial operations.  The shell is definitely still running.

I noticed that too. I even managed to make my box completely alive:
started X, opened KMail and wrote a message to lkml :-)

Weird isn't it?
--
vda
