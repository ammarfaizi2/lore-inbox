Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWEQLta@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWEQLta (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 07:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWEQLt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 07:49:29 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43408 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751296AbWEQLt3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 07:49:29 -0400
Subject: Re: libata PATA updated patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Stoffel <john@stoffel.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <17514.11859.976557.532929@smtp.charter.net>
References: <1147796037.2151.83.camel@localhost.localdomain>
	 <17514.11859.976557.532929@smtp.charter.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 17 May 2006 13:02:27 +0100
Message-Id: <1147867347.10470.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-05-16 at 15:56 -0400, John Stoffel wrote:
> Alan> I've put a patch versus -rc4 in the usual place. This should
> Alan> sort out the PIO problems and a few other glitches
> 
> Should I bother testing this on my HPT302 box?  I didn't see any
> response to my earlier bug reports, just checking to make sure I'm
> doing a usefull service here.

I've not attacked the HPT3xx hardware again yet. For one the fact that
Sergei Shtylyov is rewriting the "old style" driver for it to knock a
lot of the problems out means much of that stuff will want porting again
once he is finished

Sergei may well appreciate testers however.

Thanks for the testing so far

Alan

