Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284659AbRLIXil>; Sun, 9 Dec 2001 18:38:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284671AbRLIXib>; Sun, 9 Dec 2001 18:38:31 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:13620 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S284659AbRLIXiZ>; Sun, 9 Dec 2001 18:38:25 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: torvalds@transmeta.com, marcelo@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux/i386 boot protocol version 2.03
In-Reply-To: <200112090922.BAA11252@tazenda.transmeta.com>
	<m17krww8ky.fsf@frodo.biederman.org> <3C13DD48.3070206@zytor.com>
	<m11yi4vxvb.fsf@frodo.biederman.org> <3C13F021.3080307@zytor.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Dec 2001 16:18:24 -0700
In-Reply-To: <3C13F021.3080307@zytor.com>
Message-ID: <m1wuzwugn3.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Allowing unneeded options in protocols is a source of bugs.  You seem to think
> this is a good idea, it's not.

I think it is more that we disagree on what are unneeded options, and
what kinds of bugs happen.    Additionally there are issues with
which things are mandatory, and which things are recommended behavior,
in our communications.  

I think we agree on goals of getting the booting as simple as error
free as possible.  

Beyond that it looks like our world views are so different we do not
successfully communicate, so unless I have code or a specific case
that needs fixing, I will not try.

Eric
