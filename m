Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268997AbRHaTUT>; Fri, 31 Aug 2001 15:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269041AbRHaTUL>; Fri, 31 Aug 2001 15:20:11 -0400
Received: from wb3-a.mail.utexas.edu ([128.83.126.138]:45062 "HELO
	mail.utexas.edu") by vger.kernel.org with SMTP id <S268997AbRHaTUB>;
	Fri, 31 Aug 2001 15:20:01 -0400
Message-ID: <3B8FE2D1.A0AD0B04@mail.utexas.edu>
Date: Fri, 31 Aug 2001 13:17:37 -0600
From: "Bobby D. Bryant" <bdbryant@mail.utexas.edu>
Organization: (I do not speak for) The University of Texas at Austin (nor they for 
 me).
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-ac2 i686)
X-Accept-Language: en,fr,de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
In-Reply-To: <20010831044247.B811@gondor.com> <3B8EFF67.9010409@digitalaudioresources.org> <3B8FD501.CE027082@bigfoot.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Moore wrote:

> > It seems to work somewhat better for some if you set your BIOS to the
> > conservative settings, but that didn't help me.  I have an Epox 8KTA3+ (Via
> > KT133A) w/ a 1.4GHz Athlon and 512MB memory.  If you can't get it to work that
> > way, just stick with the K6 setting.  The point is, your hardware is likely fine
> > (fine being relative, I suppose)
> > If there are other tricks, I'm all ears.
>
> The i686 setting works perfectly.

For some people.  I have an 8KTA3+ that will boot as an i686, but starts oopsing its
shorts off after it has been up a while.

I posted some of the oopsen a few months ago, and to my feeble mind they all looked
memory related.  (Several were "bug in slab.c" kind of thing, IIRC.)

Bobby Bryant
Austin, Texas


