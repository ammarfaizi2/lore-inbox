Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVEaRaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVEaRaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 13:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVEaR3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 13:29:14 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:25963 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261887AbVEaR3A convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 13:29:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fBgiAr69195AK7cIktddJuCR+V8/RUef0Hep3nmBqKL5sd1xzYJgsbIV4KqlSrdN8x0IJ5SkQIXfrHBDDr/oXAeHlyvdrMhpGrmMNDYxXe6Tf7m8jwHQ2YQ3UiEJTiWiro0kKYWL5ITRxUhRyP8GtQqUEegYY+4gvNYzT+ZdjYA=
Message-ID: <9a874849050531102825bb19b1@mail.gmail.com>
Date: Tue, 31 May 2005 19:28:59 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [2.6 patch] Kconfig: rename "---help---" to "help" in Kconfig files (first part) (fwd)
Cc: Adrian Bunk <bunk@stusta.de>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org, Jesper Juhl <juhl-lkml@dif.dk>
In-Reply-To: <Pine.LNX.4.61.0505311314230.3728@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050531001038.GD3627@stusta.de>
	 <Pine.LNX.4.61.0505310217030.3728@scrub.home>
	 <20050531004120.GH3627@stusta.de>
	 <Pine.LNX.4.61.0505311314230.3728@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/05, Roman Zippel <zippel@linux-m68k.org> wrote:
> Hi,
> 
> On Tue, 31 May 2005, Adrian Bunk wrote:
> 
> > there's still the point that it's currently used inconsistently.
> 
> Why is it so important to fix this "inconsistency"?
> Why is it so difficult to accept that both are valid options?
> 

Let's just let this patch die quietly, ok? 

It's not important, I just made it one late evening and submitted it
in case it was wanted. It was not wanted so it should just die. No
difficulty accepting that.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
