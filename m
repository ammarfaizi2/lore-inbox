Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266845AbUHZILD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266845AbUHZILD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 04:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267767AbUHZILD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 04:11:03 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:62213 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S266845AbUHZIKz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 04:10:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Roman Zippel <zippel@linux-m68k.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: Linux 2.6.9-rc1
Date: Thu, 26 Aug 2004 11:09:43 +0300
X-Mailer: KMail [version 1.4]
Cc: Linus Torvalds <torvalds@osdl.org>,
       Daniel Andersen <anddan@linux-user.net>,
       "Sartorelli, Kevin" <Kevin.Sartorelli@openpolytechnic.ac.nz>,
       fraga@abusar.org, linux-kernel@vger.kernel.org
References: <4B2093FFC31B7A45862B62A376EA7176033C058D@mickey.topnz.ac.nz> <147680000.1093445547@[10.10.2.4]> <Pine.LNX.4.61.0408252255320.12756@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0408252255320.12756@scrub.home>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200408261109.43840.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > My assumption would be that once 2.6.9 is released, it's not uber-stable
> > immediately ... so it'd be nice to keep at least one minor rev back
> > going on the bugfix stream (eg 2.6.8.X) .... for people who want an
> > uber-stable kernel. Doing more than 1 back would indeed seem
> > counter-productive.
>
> In this case it would make more sense to get 2.6.9.1 released as quickly
> as possible instead of trying to fix old releases.

Think about a user who can't risk moving to 2.6.9.1.
[S]he wants to use 2.6.8.n+1 which have only one more fix.
-- 
vda
