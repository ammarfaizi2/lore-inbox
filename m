Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266696AbRG1P1y>; Sat, 28 Jul 2001 11:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbRG1P1o>; Sat, 28 Jul 2001 11:27:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:38197 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S266696AbRG1P1d>; Sat, 28 Jul 2001 11:27:33 -0400
To: "Paul G. Allen" <pgallen@randomlogic.com>
Cc: "Linux kernel developer's mailing list" 
	<linux-kernel@vger.kernel.org>
Subject: Re: TYan K7 Thunder: AMD-760 MP support
In-Reply-To: <3B614BDB.BE13848B@randomlogic.com>
	<m18zhae0oa.fsf@frodo.biederman.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Jul 2001 09:21:31 -0600
In-Reply-To: <m18zhae0oa.fsf@frodo.biederman.org>
Message-ID: <m1y9p9cc5g.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

ebiederm@xmission.com (Eric W. Biederman) writes:

> "Paul G. Allen" <pgallen@randomlogic.com> writes:
>  
> > Do the newer kernel releases support the 760 MP chipset? Will they
> > anytime soon? (If not I will see if I can put it in myself.)
> 
> There is better support in 2.4.7 (especially IDE) but there is not complete
> support.  

Grr.  I lied.  There is code on linux-ide.org that contains a native ide
driver.  I thought I saw it in 2.4.7 but I was seeing things.

Eric
