Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268663AbTBZGcY>; Wed, 26 Feb 2003 01:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268664AbTBZGcY>; Wed, 26 Feb 2003 01:32:24 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:40711 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S268663AbTBZGcX>; Wed, 26 Feb 2003 01:32:23 -0500
Message-Id: <200302260616.h1Q6GAs21894@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Michael Hayes <mike@aiinc.ca>, linux-kernel@vger.kernel.org
Subject: Re: [REVISED][PATCH] Spelling fixes for 2.5.63 - can't
Date: Wed, 26 Feb 2003 08:12:52 +0200
X-Mailer: KMail [version 1.3.2]
References: <200302252248.h1PMmBl29251@aiinc.aiinc.ca>
In-Reply-To: <200302252248.h1PMmBl29251@aiinc.aiinc.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 February 2003 00:48, Michael Hayes wrote:
> Removed changes to comments in .S files -- gcc does not like
> apostrophes in assembler comments.
>
> This fixes:
>     cant -> can't (28 occurrences)

Some editors which do syntax highlighting have bugs
and treat ' like string delimiter even in comments.
I usually "fix" it by removing apostrophes from
"can't" ;)
--
vda
