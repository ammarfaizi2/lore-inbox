Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267006AbUBMN5g (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 08:57:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267019AbUBMN5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 08:57:36 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:30468 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267006AbUBMN5d convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 08:57:33 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Maciej Zenczykowski <maze@cela.pl>
Subject: Re: PATCH, RFC: 2.6 Documentation/Codingstyle
Date: Fri, 13 Feb 2004 15:57:16 +0200
X-Mailer: KMail [version 1.4]
Cc: Junio C Hamano <junkio@cox.net>, Michael Frank <mhf@linuxmail.org>,
       linux kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0402131322280.12513-100000@gaia.cela.pl>
In-Reply-To: <Pine.LNX.4.44.0402131322280.12513-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200402131557.16971.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 February 2004 14:37, Maciej Zenczykowski wrote:
> > 126MB LOWMEM available
> > Detected 1196.031 MHz processor
> > Intel machine check architecture supported
> > POSIX conformance testing by UNIFIX
> > PCI: Probing PCI hardware
>
> In your post only the above could be considered sentences and even then
> most are really too short, or end with numerals or acronyms which make
> dots look stupid.  Personally I'd think the "Intel machine check
> architecture supported." message looks better with a period and I'd leave
> all the rest alone.  Nevertheless, all 5 of the above could possibly end
> with periods, the rest never.

If we adopt this, 'what is a sentence and what is not'
will be debated again and again at lkml. For
each particular sentence. Do you want that? ;)

OTOH 'no trailing dots in logs' rule is simple and not
too ugly for any log message.
-- 
vda
