Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268760AbTBZOuj>; Wed, 26 Feb 2003 09:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268764AbTBZOuj>; Wed, 26 Feb 2003 09:50:39 -0500
Received: from mailrelay1.lanl.gov ([128.165.4.101]:18602 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S268760AbTBZOui>; Wed, 26 Feb 2003 09:50:38 -0500
Subject: Re: [REVISED][PATCH] Spelling fixes for 2.5.63 - can't
From: Steven Cole <elenstev@mesatop.com>
To: vda@port.imtp.ilyichevsk.odessa.ua
Cc: Michael Hayes <mike@aiinc.ca>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200302260616.h1Q6GAs21894@Port.imtp.ilyichevsk.odessa.ua>
References: <200302252248.h1PMmBl29251@aiinc.aiinc.ca> 
	<200302260616.h1Q6GAs21894@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 26 Feb 2003 07:56:24 -0700
Message-Id: <1046271385.6615.174.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-25 at 23:12, Denis Vlasenko wrote:
> On 26 February 2003 00:48, Michael Hayes wrote:
> > Removed changes to comments in .S files -- gcc does not like
> > apostrophes in assembler comments.
> >
> > This fixes:
> >     cant -> can't (28 occurrences)
> 
> Some editors which do syntax highlighting have bugs
> and treat ' like string delimiter even in comments.
> I usually "fix" it by removing apostrophes from
> "can't" ;)
> --
> vda

Sounds like time for a better editor. ;)

A better fix for you might be s/can't/cannot/g.

Steven

