Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266259AbUHSOjn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266259AbUHSOjn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 10:39:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266254AbUHSOjn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 10:39:43 -0400
Received: from as8-6-1.ens.s.bonet.se ([217.215.92.25]:40340 "EHLO
	zoo.weinigel.se") by vger.kernel.org with ESMTP id S266259AbUHSOfb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 10:35:31 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, kernel@wildsau.enemy.org,
       diablod3@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	<d577e5690408190004368536e9@mail.gmail.com>
	<4124A024.nail7X62HZNBB@burner>
	<1092919260.28141.30.camel@localhost.localdomain>
From: Christer Weinigel <christer@weinigel.se>
Organization: Weinigel Ingenjorsbyra AB
Date: 19 Aug 2004 16:35:29 +0200
In-Reply-To: <1092919260.28141.30.camel@localhost.localdomain>
Message-ID: <m3pt5n42mm.fsf@zoo.weinigel.se>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> The GPL gives modification rights explicitly and doesn't say "except
> ones I don't like". The GPL addresses this issue in a different manner
> 
>    a) You must cause the modified files to carry prominent notices
>     stating that you changed the files and the date of any change.
> 
> Any SuSE (or Red Hat or other) modifications should thus clearly state
> they are modified. If people are not marking the files as modified and
> you want them to you'd have a legitimate rant.

As far as I can tell SuSE has had the following text in the cdrecord
banner for a while:

Cdrecord-Clone-dvd 2.01a27 (i686-suse-linux) Copyright (C) 1995-2004 Jörg Schilling
Note: This version is an unofficial (modified) version with DVD support
Note: and therefore may have bugs that are not present in the original.
Note: Please send bug reports or support requests to http://www.suse.de/feedback
Note: The author of cdrecord should not be bothered with problems in this version.

So I wonder what Jörg is complaining about.

  /Christer

-- 
"Just how much can I get away with and still go to heaven?"

Freelance consultant specializing in device driver programming for Linux 
Christer Weinigel <christer@weinigel.se>  http://www.weinigel.se
