Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267233AbTAUUy7>; Tue, 21 Jan 2003 15:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267232AbTAUUy7>; Tue, 21 Jan 2003 15:54:59 -0500
Received: from mail.webmaster.com ([216.152.64.131]:56227 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S267231AbTAUUy5> convert rfc822-to-8bit; Tue, 21 Jan 2003 15:54:57 -0500
From: David Schwartz <davids@webmaster.com>
To: <dana.lacoste@peregrine.com>
CC: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Tue, 21 Jan 2003 13:04:01 -0800
In-Reply-To: <1043177271.1397.149.camel@dlacoste.ottawa.loran.com>
Subject: Re: Is the BitKeeper network protocol documented?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030121210403.AAA21365@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Thus, it's required under the GPL to distribute the source code that
>the binary modules were compiled from, in a form that can be
>modified.
...
>It is not important that the re-distributor maintain changes over
>time, nor that the re-distributor even understand what's going on
>in the code, what's important is that the end user doesn't get
>something that they can't make changes to, if need be.

	Suppose I take the Linux kernel and make lots of changes to it. I 
then obfuscate the source and hand the source to another person. I've 
clearly not violated the GPL at this point because I haven't 
distributed anything but source.

	That person compiles the source and distributes it. Has he violated 
the GPL? The only way your reply can make any sense is if it's okay 
to distribute obfuscated source to meet GPL requirements if it was 
the obfuscated source that was compiled to make the executable that 
was distributed.

	It is, at least in principle, possible to make changes to obfuscated 
source. I submit that this is a possible interpretation of the GPL's 
"preferred form" clause. However, I don't think it's what the GPL 
intended and I wouldn't bet money that a court would go along with 
it.

>Dana "Why didn't David reply in private to the private reply?"

	I did. I replied privately to your private replies and publicly to 
your public replies.

	DS


