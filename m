Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262655AbVDHCKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262655AbVDHCKx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 22:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVDHCKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 22:10:53 -0400
Received: from [81.168.75.8] ([81.168.75.8]:47476 "EHLO henning.makholm.net")
	by vger.kernel.org with ESMTP id S262655AbVDHCKp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 22:10:45 -0400
To: linux-kernel@vger.kernel.org, debian-legal@lists.debian.org,
       linux-acenic@sunsite.dk
Subject: Re: non-free firmware in kernel modules, aggregation and unclear
 copyright notice.
References: <08Gc5.A.AFC.QJPVCB@murphy> <4255244B.6070204@almg.gov.br>
From: Henning Makholm <henning@makholm.net>
Date: Fri, 08 Apr 2005 03:10:43 +0100
In-Reply-To: <4255244B.6070204@almg.gov.br> (Humberto Massa's message of
 "Thu, 07 Apr 2005 09:15:07 -0300")
Message-ID: <87is2ydnmk.fsf@kreon.lan.henning.makholm.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scripsit Humberto Massa <humberto.massa@almg.gov.br>

> After a *lot* of discussion, it was deliberated on d-l that
> this is not that tricky at all, and that the "mere
> aggregation" clause applies to the combination, for various
> reasons, with a great degree of safety.

When was this alleged conclusion reached? I remember nothing like
that.

> No-one is saying that the linker "merely aggregates" object
> code for the driver; what *is* being said is: in the case of
> firmware, especially if the firmware is neither a derivative
> work on the kernel (see above) nor the firmware includes part
> of the kernel (duh), it is *fairly* *safe* to consider the
> intermixing of firmware bytes with kernel binary image bytes
> in an ELF object file as mere aggregation.

No, it is completely wrong to say that the object file is merely an
aggregation. The two components are being coupled much more tightly
than in the situation that the GPL discribes as "mere aggregation".

-- 
Henning Makholm                                   "Hør, hvad er det egentlig
                                          der ikke kan blive ved med at gå?"
