Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261153AbSIZNQp>; Thu, 26 Sep 2002 09:16:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261165AbSIZNQp>; Thu, 26 Sep 2002 09:16:45 -0400
Received: from pc1-cwma1-5-cust128.swa.cable.ntl.com ([80.5.120.128]:24824
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261153AbSIZNQo>; Thu, 26 Sep 2002 09:16:44 -0400
Subject: Re: [PATCH] Module rewrite 6/20: streq
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020925032201.A38102C12D@lists.samba.org>
References: <20020925032201.A38102C12D@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Sep 2002 14:26:55 +0100
Message-Id: <1033046815.1348.6.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-25 at 04:01, Rusty Russell wrote:
> Name: streq implementation
> Author: Rusty Russell
> Status: Trivial
> Depends: Misc/strcspn.patch.gz
> 
> D: I can't believe that after all these years I still make the "sense
> D: of strcmp" mistake.  So it's time to reintroduce my favorite macro.

So you replace something all the competent programmers understand with
some weird Rusty specific macro that just makes it harder still for
other people to follow kernel code.

Why ?


