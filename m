Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269460AbUJSPR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269460AbUJSPR6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 11:17:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269464AbUJSPR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 11:17:57 -0400
Received: from rproxy.gmail.com ([64.233.170.192]:6927 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269460AbUJSPRo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 11:17:44 -0400
DomainKey-Signature: a=rsa-sha1; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=M3PXDnsBG6FPhTA7LkiRL/rrIUGR+j75A+72ktDzqb0sq2nMgyQY/W8ZvqPrCYbhG726gDuNs603V5j2Jqt31Sw7mYBqbiyyPUPaNq6RwO1rjCKxz/upcW2bviKdbrA+jnMfSuSRYL8jZh6OyT3mcdlnDOUVo1dX4pMqKXsnaQg
Message-ID: <7aaed09104101908174a9e430a@mail.gmail.com>
Date: Tue, 19 Oct 2004 17:17:42 +0200
From: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
Reply-To: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <espenfjo@gmail.com>
To: Andi Kleen <ak@muc.de>
Subject: Re: 2.6.9-rc4-mm1 amd64 Computer crashes on "Freeing unused kernel memory: 200k"
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3wtxn67h2.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <2QMVB-2nB-13@gated-at.bofh.it>
	 <m3wtxn67h2.fsf@averell.firstfloor.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004 23:29:13 +0200, Andi Kleen <ak@muc.de> wrote:
> Espen Fjellvær Olsen <espenfjo@gmail.com> writes:
> 
> > I recently got a new AMD64 3400+ computer, i'm installing gentoo from
> > the gentoo-amd64-livecd.
> > All goes well, until i try to boot my newly compiled kernel.
> > I't stops at "Freeing unused kernel memory: 200k", no oopses or other
> > information.
> > I compiled it with gcc-3.3.4.
> 
> Does it work with an mainline kernel like 2.6.9rc4 or "2.6.9-final" ?
> 
> -Andi
> 
> 
2.6.9-rc4 won't work either.
I have to boot into a plain 32bit system to run lilo, since it won`t
install on gentoo-64, and grub wont work.


-- 
Mvh / Best regards
Espen Fjellvær Olsen
espenfjo@gmail.com
Norway
