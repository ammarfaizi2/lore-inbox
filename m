Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262754AbVDHIFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262754AbVDHIFG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 04:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbVDHIBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 04:01:04 -0400
Received: from smtp5.wanadoo.fr ([193.252.22.26]:41129 "EHLO smtp5.wanadoo.fr")
	by vger.kernel.org with ESMTP id S262739AbVDHH7C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 03:59:02 -0400
X-ME-UUID: 20050408075900620.977A41C00104@mwinf0508.wanadoo.fr
Date: Fri, 8 Apr 2005 09:54:35 +0200
To: Henning Makholm <henning@makholm.net>
Cc: linux-kernel@vger.kernel.org, debian-legal@lists.debian.org,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Message-ID: <20050408075435.GE9057@pegasos>
Reply-To: debian-legal@lists.debian.org
References: <08Gc5.A.AFC.QJPVCB@murphy> <4255244B.6070204@almg.gov.br> <87is2ydnmk.fsf@kreon.lan.henning.makholm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87is2ydnmk.fsf@kreon.lan.henning.makholm.net>
User-Agent: Mutt/1.5.6+20040907i
From: Sven Luther <sven.luther@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2005 at 03:10:43AM +0100, Henning Makholm wrote:
> Scripsit Humberto Massa <humberto.massa@almg.gov.br>
> 
> > After a *lot* of discussion, it was deliberated on d-l that
> > this is not that tricky at all, and that the "mere
> > aggregation" clause applies to the combination, for various
> > reasons, with a great degree of safety.
> 
> When was this alleged conclusion reached? I remember nothing like
> that.

  http://lists.debian.org/debian-legal/2005/03/msg00273.html

and :

  http://lists.debian.org/debian-legal/2005/03/msg00283.html

and the following thread. These where linked from the original mail in this
thread.

> > No-one is saying that the linker "merely aggregates" object
> > code for the driver; what *is* being said is: in the case of
> > firmware, especially if the firmware is neither a derivative
> > work on the kernel (see above) nor the firmware includes part
> > of the kernel (duh), it is *fairly* *safe* to consider the
> > intermixing of firmware bytes with kernel binary image bytes
> > in an ELF object file as mere aggregation.
> 
> No, it is completely wrong to say that the object file is merely an
> aggregation. The two components are being coupled much more tightly
> than in the situation that the GPL discribes as "mere aggregation".

So read the analysis and comment on it if you disagree, but let's take it to
debian-legal alone, ok ? 

Friendly,

Sven Luther

