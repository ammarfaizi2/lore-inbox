Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261986AbVGaWGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261986AbVGaWGj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 18:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbVGaWGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 18:06:39 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:784 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261986AbVGaWGi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 18:06:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=XypDkl/dGYxg+q/fP0kK1/UViNqj/YpVYZeOwg3BXdlQvPsMPdw9vYHMe4z/dVf7HOkTpzjM15bJrm3j9URk1qMy7bnDF9lG21LKFYq02RdKAd1QVEZskjpgC7gAtPek04UdipZ7262suwrJIvaI5hTFVJO9E5VqK44ctw70ZCE=
Message-ID: <c25b25320507311506258736b7@mail.gmail.com>
Date: Sun, 31 Jul 2005 22:06:38 +0000
From: Richard Hubbell <richard.hubbell@gmail.com>
Reply-To: Richard Hubbell <richard.hubbell@gmail.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Where's the list of needed hardware for donating?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050730092904.GC2013@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c25b253205072710481c157e4c@mail.gmail.com>
	 <20050728230047.GA4385@elf.ucw.cz>
	 <c25b2532050728190311d6c339@mail.gmail.com>
	 <20050730092904.GC2013@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/05, Pavel Machek <pavel@ucw.cz> wrote:
-snip-snip- 
> > The hardware I have may outdated/esoteric.   I take it that there is
> > no such list then?
> > Maybe it's better not to support esoteric hardware.
> 
> Post a list somewhere...

Ok, here's the list:

Adaptec AHA-1510A
(ISA, centronix-style external connector with terminator, one internal
ribbon cable,
I probably have some centronix-style external cables around too, this
card doesn't have it's own boot ROM)

Gravis UltraSound a.k.a. GUS
(ISA, fully loaded with memory, 1megabyte (I think))

Pertec MyTape 800
(I think this is a QIC tape drive that connects via the floppy interface)

TEAC 1.44  3.5 inch Floppy FDR
(FD-235HF)

Rocket Port 8-port serial board
(ISA, 8 - RJ11 jacks, made by Comtrol, brand-new in-box)
