Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267099AbSLRBTx>; Tue, 17 Dec 2002 20:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbSLRBTx>; Tue, 17 Dec 2002 20:19:53 -0500
Received: from f155.law9.hotmail.com ([64.4.9.155]:11525 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S267099AbSLRBTx>;
	Tue, 17 Dec 2002 20:19:53 -0500
X-Originating-IP: [62.99.88.10]
From: "joe user" <joe_user35@hotmail.com>
To: acme@conectiva.com.br, andersg@0x63.nu
Cc: linux-kernel@vger.kernel.org
Subject: Re: netstat and 2.5.5[12]
Date: Wed, 18 Dec 2002 02:27:46 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Message-ID: <F155vsq9IcVux1Zcn8T000004c6@hotmail.com>
X-OriginalArrivalTime: 18 Dec 2002 01:27:47.0044 (UTC) FILETIME=[ABC9E240:01C2A634]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Em Mon, Dec 16, 2002 at 01:45:53PM +0100, Anders Gustafsson escreveu:
> > On Mon, Dec 16, 2002 at 01:06:32PM +0100, joe user wrote:
> > > Is required a new net-tools package required to run 2.5.5[12]? If you 
>run
> > > netstat -t the process just hang forever, and is unkillable.
> >
> > Happens here too.
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=103974450111945&w=2
> >
> > A cat /proc/net/tcp causes the same problem, so not tools problem.
>
>I'm looking into this, do you have ipv6 connections?

I have ipv6 support compiled in but no ipv6 connections at all that I'm 
aware of. This is a fresh install of redhat8 running X and several rpc 
daemons: rstatd, rusersd, rwalld. I'm running sshd and rwhod too. Not sure 
if any of these daemons are compiled with ipv6 support.

Joe

_________________________________________________________________
Charla con tus amigos en línea mediante MSN Messenger: 
http://messenger.microsoft.com/es

