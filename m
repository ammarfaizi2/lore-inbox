Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262151AbVFRTdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVFRTdM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Jun 2005 15:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVFRTdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Jun 2005 15:33:12 -0400
Received: from zproxy.gmail.com ([64.233.162.195]:35164 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262151AbVFRTdF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Jun 2005 15:33:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NzTgx4lNThlpwneKh9psXOyqxqD6dxmfI+XmmGAmPn1n4SKSMHv/K+g34WuLiq4WnB6MsI0IBhgUhLl4vIfvZWtCydza3X5ZpVA49WB7dRXpLM32kc5A1ZsPSwRbkUahq8zrtAtcH5v3RKT+FNRglWUw5C6jNDkuIuhcpi8hpPw=
Message-ID: <9a8748490506181233675f2fd5@mail.gmail.com>
Date: Sat, 18 Jun 2005 21:33:05 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Nick Warne <nick@linicks.net>
Subject: Re: Linux 2.6.12
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200506182005.28254.nick@linicks.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200506182005.28254.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/18/05, Nick Warne <nick@linicks.net> wrote:
> Steven Rostedt <rostedt () goodmis ! org> wrote:
> 
> > This is somewhat experimental at this time, but it should be safe,
> > as long as you aren't building this as a module and then removing it.
> 
> > If unsure, say Y. Do not say M.
> 
> >  USB Monitor (USB_MON) [M/n/?] (NEW)
> > --------------
> 
> > I really like my options. :-)
> 
> > OK, I have CONFIG_USB as a module, but I really thought that this was
> > pretty amusing.
> 
> Heh.  When I was sussing 2.6.12 stuff today, I really thought it was me
> buggering up something.  So after reading a lot, I wondered (neurotically)
> if I was doing anything wrong (after all this time, it's likely).
> 
> > make help reveals:
> 
>  randconfig      - New config with random answer to all options
> 
> So 'make randconfig' is the one to use!  What one earth is that for?
> 
Testing unusual combinations of build options to discover bugs that
are rarely encountered during most peoples normal use.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
