Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266829AbSJUO34>; Mon, 21 Oct 2002 10:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266826AbSJUO3y>; Mon, 21 Oct 2002 10:29:54 -0400
Received: from ns.suse.de ([213.95.15.193]:3088 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266808AbSJUO3r>;
	Mon, 21 Oct 2002 10:29:47 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, rml@tech9.net, akpm@digeo.com
Subject: Re: benchmarks of O_STREAMING in 2.5
References: <1034823201.722.429.camel@phantasy.suse.lists.linux.kernel> <1035211132.27309.131.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 21 Oct 2002 16:35:50 +0200
In-Reply-To: Alan Cox's message of "21 Oct 2002 16:26:54 +0200"
Message-ID: <p73y98r7tbt.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> All you now need to do is make it work with an API thats usable by the
> other 99% of real world apps, is extensible and sensible ways and
> therefore can be used.

An streaming hint as chattr would be quite nice.

-Andi
