Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753776AbWKGNfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbWKGNfZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 08:35:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753799AbWKGNfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 08:35:25 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:6087 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1753780AbWKGNfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 08:35:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EmybvjZvlRQMujjbwXlschlylGwQR3YTd5eovDVJqHAw7hUfZ/wTJ8Wv1insrOIOUYuI5cOgAObOkNFdsxKODhqbZZmlfpxpHG8dS5vBj8re6qtIWc+dpDrDu5jmvjMmVeGCEo01PLd1YM4AVcZsT47EOYVyWvsgHbRtlrkmBi4=
Message-ID: <653402b90611070535hd41867m232fdad39da3c4c5@mail.gmail.com>
Date: Tue, 7 Nov 2006 14:35:23 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Avi Kivity" <avi@qumranet.com>
Subject: Re: [PATCH 12/14] KVM: x86 emulator
Cc: "Arjan van de Ven" <arjan@infradead.org>, "Pavel Machek" <pavel@ucw.cz>,
       kvm-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <4550889C.2020708@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <454E4941.7000108@qumranet.com>
	 <20061105204035.DF0F62500A7@cleopatra.q>
	 <20061107124912.GA23118@elf.ucw.cz> <4550823E.2070108@qumranet.com>
	 <1162904459.3138.142.camel@laptopd505.fenrus.org>
	 <4550889C.2020708@qumranet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/06, Avi Kivity <avi@qumranet.com> wrote:
> Arjan van de Ven wrote:
> >> The entire patchset is GPL'ed.  Do you mean to make it explicit?  If so,
> >> how?  I'd rather not copy the entire license into each file.
> >>
> >
> > a simple one liner like
> > "This file is licensed under the terms of the GPL v2 license"
> > (add "or later" if you feel like doing that)
> > is going to be generally useful.
> >
> > At least many many legal departments really prefer at least that minimum
> > line to be there for each file; some even want a much longer blurb.
> >
>
> Okay.  I hate to use the word "official", but is there an official
> position on this somewhere?
>

I don't think so. The best option is to use the 15 lines version so
there won't be any problem in the future. Many people use only one
line. Other simply write "License: GPLv2" or something like that.
