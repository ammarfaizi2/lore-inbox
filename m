Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964903AbWGHQuo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964903AbWGHQuo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 12:50:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWGHQun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 12:50:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42182 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964903AbWGHQun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 12:50:43 -0400
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
From: Arjan van de Ven <arjan@infradead.org>
To: Sunil Kumar <devsku@gmail.com>
Cc: Bojan Smojver <bojan@rexursive.com>, Pavel Machek <pavel@ucw.cz>,
       Avuton Olrich <avuton@gmail.com>, Olivier Galibert <galibert@pobox.com>,
       Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
In-Reply-To: <ce9ef0d90607080942w685a6b60q7611278856c78ac0@mail.gmail.com>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <20060707215656.GA30353@dspnet.fr.eu.org>
	 <20060707232523.GC1746@elf.ucw.cz>
	 <200607080933.12372.ncunningham@linuxmail.org>
	 <20060708002826.GD1700@elf.ucw.cz> <m2d5cg1mwy.fsf@tnuctip.rychter.com>
	 <1152353698.2555.11.camel@coyote.rexursive.com>
	 <1152355318.3120.26.camel@laptopd505.fenrus.org>
	 <ce9ef0d90607080942w685a6b60q7611278856c78ac0@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 18:50:34 +0200
Message-Id: <1152377434.3120.69.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 09:42 -0700, Sunil Kumar wrote:
>         Multiple all-half-working implementations is insane. It means
>         bugs don't
>         get fixed, it means there isn't going to be ANY implementation
>         that is 
>         good enough for a broad audience. People will just switch to
>         another one
>         rather than reporting and causing even the most simple bugs to
>         get
> 
> you are afraid nobody is going to use uswsusp (because it doesn't work
> or is not useful) and not going to report any bugs against it, and it
> will cease to exist over time. I think that is very good. Survival of
> the good. The winner will be decided by users automatically. Not by
> someone who 


note that I'm not picking sides. I don't care which ego gets to win.
What do care about that Linux ends up with a good implementation,
whatever that is. I have no idea is uswsusp will make it (in fact it
feels fragile to me, but then again all sw suspend implementations
including swsusp2 feel fragile to me). But for crying out loud

PICK ONE AND MAKE IT GOOD.

Bang heads together. Go for beer at OLS. I don't care how, but anything
to prevent the insane thing of having multiple half working
implementations.



