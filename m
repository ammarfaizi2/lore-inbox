Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbUDKQ6d (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Apr 2004 12:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUDKQ6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Apr 2004 12:58:33 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:63244 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262415AbUDKQ6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Apr 2004 12:58:32 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "J. Ryan Earl" <heretic@clanhk.org>
Subject: Re: Rewrite Kernel
Date: Sun, 11 Apr 2004 19:58:23 +0300
User-Agent: KMail/1.5.4
Cc: Mohamed Aslan <mkernel@linuxmail.org>, linux-kernel@vger.kernel.org
References: <20040407125406.209FC39834A@ws5-1.us4.outblaze.com> <200404102021.36745.vda@port.imtp.ilyichevsk.odessa.ua> <407851AB.2020409@clanhk.org>
In-Reply-To: <407851AB.2020409@clanhk.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404111958.23431.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 10 April 2004 22:57, J. Ryan Earl wrote:
> Denis Vlasenko wrote:
> >>I doubt you would be capable of generating assembly that would be any
> >>faster than gcc, and you would inherit all the accidental difficulties
> >>that come with engineering software at a lower-level.
> >
> >No, writing 'better than gcc' assembly is easy, gcc is far from stellar
> >in this regard. But it's painfully slow and non-portable.
>
> How can "painfully slow and non-portable" be better?  You mean faster?

*writing* asm code is painfully slow and code is not portable.
That's why no sane person will write kernel in asm.
--
vda

