Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbWEMUwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbWEMUwX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 16:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWEMUwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 16:52:23 -0400
Received: from [4.21.254.118] ([4.21.254.118]:5789 "EHLO suzuka.mcnaught.org")
	by vger.kernel.org with ESMTP id S1750989AbWEMUwX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 16:52:23 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mark Rosenstand <mark@borkware.net>, linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
References: <20060513103841.B6683146AF@hunin.borkware.net>
	<1147517786.3217.0.camel@laptopd505.fenrus.org>
	<20060513110324.10A38146AF@hunin.borkware.net>
	<1147518432.3217.2.camel@laptopd505.fenrus.org>
	<87r72yi346.fsf@suzuka.mcnaught.org>
	<1147528850.3217.5.camel@laptopd505.fenrus.org>
From: Douglas McNaught <doug@mcnaught.org>
Date: Sat, 13 May 2006 16:52:16 -0400
In-Reply-To: <1147528850.3217.5.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Sat, 13 May 2006 16:00:49 +0200")
Message-ID: <87ejyxir5r.fsf@suzuka.mcnaught.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

>> Every Unix I've ever seen works this way.  It'd be nice to have
>> unreadable executable scripts, but no one's ever done it.
>
>
> hmm I'm less convinced of what that would bring anyone. Just like you
> can get to the content of elf files anyway, you can get to the content
> of the script (just attach a debugger for example)
>
> execute == read + action

Good point.

-Doug
