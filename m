Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVJHPwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVJHPwk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 11:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932162AbVJHPwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 11:52:40 -0400
Received: from host62-24-231-115.dsl.vispa.com ([62.24.231.115]:3755 "EHLO
	orac.walrond.org") by vger.kernel.org with ESMTP id S932161AbVJHPwj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 11:52:39 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org, Lukasz Kosewski <lkosewsk@gmail.com>
Subject: Re: Anybody know about nforce4 SATA II hot swapping + linux raid?
Date: Sat, 8 Oct 2005 16:52:34 +0100
User-Agent: KMail/1.8.2
Cc: Molle Bestefich <molle.bestefich@gmail.com>, htejun@gmail.com,
       linux-raid@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
References: <200510071111.46788.andrew@walrond.org> <200510081555.41159.andrew@walrond.org> <355e5e5e0510080801p88f04c7x7992c3d75f20e65c@mail.gmail.com>
In-Reply-To: <355e5e5e0510080801p88f04c7x7992c3d75f20e65c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510081652.35347.andrew@walrond.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 October 2005 16:01, Lukasz Kosewski wrote:
>
> I've actually been working on implementing the core set of routines
> that will allow for hot-swapping SATA drives in Linux.  The core is
> not quite ready yet, but you can expect the next iteration within the
> week.  Once the core is integrated, someone will have to implement
> capturing hotswap events on the nForce4 SATA controller, and using the
> core functions.  I don't know how long that will take, but if the
> Linux SATA maintainer, Jeff Garzik (CCed on this email) knows how to
> do it, then it might be just a few weeks' time.

Good news! I'll be watching with great interest, and I'm sure I won't be 
alone. 

>
> That said, if you want to use this for servers you might still want to
> wait a bit before committing your resources to this :)

Yeah; I need these servers working by November, so I'll have to find another 
solution for now. But perhaps the next cluster can use your work? Hope so!

Andrew Walrond
