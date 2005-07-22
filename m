Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVGVU27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVGVU27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 16:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbVGVU27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 16:28:59 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:1406 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261373AbVGVU26 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 16:28:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AsLiHFbdn/wdqmeqvVoki47doSxEuD0mzDcVw2ff5OY0woBqphwxENagb0ZEz+voEkJiLgmoyFKysDYVrQA+bQXkBzbjMm4PPYqBaDP8lni5ZpirGbtDNScP7oiJQQ746JgzGB7PLrRxfEYilFyJHSYPKXD+u2l8M9aUj5ZMUIQ=
Message-ID: <9a87484905072213286cb6e49b@mail.gmail.com>
Date: Fri, 22 Jul 2005 22:28:58 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: kernel guide to space
Cc: Patrick Draper <pdraper@gmail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050722192103.GA8556@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050711145616.GA22936@mellanox.co.il>
	 <9a87484905072005596f2c2b51@mail.gmail.com>
	 <m3pstd2jfu.fsf@defiant.localdomain>
	 <6981e08b050722101241ba2f3e@mail.gmail.com>
	 <20050722192103.GA8556@mars.ravnborg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/05, Sam Ravnborg <sam@ravnborg.org> wrote:
> On Fri, Jul 22, 2005 at 12:12:12PM -0500, Patrick Draper wrote:
> > Why isn't a code formatting program used? People could write the code
> > as they like to write it, then format it automatically in a standard
> > way before it gets put into the kernel.
> There is.
> scripts/Lindent
> 
> But sometimes it fails to do the job properly and some hand formatting
> is needed. Also much of the kernel is not new stuff but expanding or
> fixing old stuff.
> 
Ehh, that's exactely why I wrote "You can do some cleanup that way,
but not everything..."

        Jesper
