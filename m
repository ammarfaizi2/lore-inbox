Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268722AbTBZL5V>; Wed, 26 Feb 2003 06:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268724AbTBZL5V>; Wed, 26 Feb 2003 06:57:21 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:30474 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S268722AbTBZL5U>; Wed, 26 Feb 2003 06:57:20 -0500
Message-Id: <200302261200.h1QC0gs23846@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Steven Cole <elenstev@mesatop.com>
Subject: Re: [PATCH] 2.5.63-current replace its with it's where appropriate.
Date: Wed, 26 Feb 2003 13:57:42 +0200
X-Mailer: KMail [version 1.3.2]
Cc: LKML <linux-kernel@vger.kernel.org>
References: <1046227493.7527.272.camel@spc1.mesatop.com>
In-Reply-To: <1046227493.7527.272.camel@spc1.mesatop.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 February 2003 04:44, Steven Cole wrote:
> This patch replaces its (possessive of it) with it's (it is)
> in the following cases where "it is" is meant.
>
> its a   -> it's a
> its an  -> it's an
> its not -> it's not

I'd say it's ok to fix misspellings but this apostrophe
chasing is a bit too much. What comes next? Patches to fix
violations of "two spaces after the dot" rule?

Single quotes in comments do confuse gcc _and_ some
text editors with syntax highlighting.
--
vda
