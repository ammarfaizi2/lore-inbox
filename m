Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262937AbTARHOj>; Sat, 18 Jan 2003 02:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbTARHOj>; Sat, 18 Jan 2003 02:14:39 -0500
Received: from mail.webmaster.com ([216.152.64.131]:4336 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S262877AbTARHOi> convert rfc822-to-8bit; Sat, 18 Jan 2003 02:14:38 -0500
From: David Schwartz <davids@webmaster.com>
To: <jamie@shareable.org>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Fri, 17 Jan 2003 23:23:36 -0800
In-Reply-To: <20030118051012.GA18720@bjl1.asuk.net>
Subject: Re: Is the BitKeeper network protocol documented?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030118072337.AAA10729@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2003 05:10:12 +0000, Jamie Lokier wrote:

>It doesn't require that you distribute the tools for editing the
>source, though.  For example I believe it is fine to distribute a
>program for Microsoft Visual Studio, in the form of the files you
>would actually use with Visual Studio, even though the format of 
>some of those files is not documented.

	So then suppose the tool I use for modifying the source code 
unpacks/decrypts it, allows changes, and then packs/encrypts it 
again. Suppose further that this tool is proprietary and not 
available without onerous licensing requirements. Would you say 
releasing the source code thus packed/encrypted meets the GPL?

	If not, then what would? The decrypted/unpacked form of the source 
is not the preferred form for making modifications.

	It seems to me that if you can't distribute the source in its 
preferred form for modification such that it can actually be used and 
modified without complying with some other more restrictive license, 
you cannot comply with the GPL. The alternative is to say that you 
can distribute utterly useless "source" and still comply with the 
GPL.

	Anyway, this has veered off-topic for this list. I apologize for 
that.

	DS


