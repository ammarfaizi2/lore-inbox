Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbTLEFCG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 00:02:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbTLEFCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 00:02:06 -0500
Received: from mail-09.iinet.net.au ([203.59.3.41]:46048 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262228AbTLEFCC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 00:02:02 -0500
Message-ID: <3FD00CD2.2020900@cyberone.com.au>
Date: Fri, 05 Dec 2003 15:42:58 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Chubb <peter@chubb.wattle.id.au>
CC: Paul Adams <padamsdev@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>	<3FCFCC3E.8050008@cyberone.com.au> <16336.2094.950232.375620@wombat.chubb.wattle.id.au>
In-Reply-To: <16336.2094.950232.375620@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Chubb wrote:

>>>>>>"Nick" == Nick Piggin <piggin@cyberone.com.au> writes:
>>>>>>
>
>Nick> Paul Adams wrote:
>
>
>Nick> Seriously: What about specifically a module that includes the
>Nick> Linux Kernel's headers and uses its APIs? I don't think you
>Nick> could say that is definitely not a derivative work.
>
>As far as I know, interfacing to a published API doesn't infringe
>copyright.
>

So binary modules don't infringe copyright and aren't derived works?
If so then the way to control access to the kernel is to control the
"published API" ie. the api/abi exported modules, and exceptions for
GPL modules are useless. Hmm.

>
>Note:
>
>
>Paul>   A standard filter is that you eliminate an element if "The
>Paul> element's expression was dictated by external factors, such as
>Paul> using an existing file format or interoperating with another
>Paul> program."  Computer Associates v. Altai specifically discusses
>Paul> the need to filter elements related to "compatibility
>Paul> requirements of other programs with which a program is designed
>Paul> to operate in conjunction." 
>Paul> http://www.bitlaw.com/source/cases/copyright/altai.html
>
>
>If you don't accept this, then maybe you have to start accepting SCO's
>claims on JFS, XFS, &c.
>

Not quite sure what you mean here. As far as I was aware, SCO doesn't
have any copyrights or patents on any code in the Linux Kernel so it is
not a similar situation. I haven't followed the SCO thing closely though.


