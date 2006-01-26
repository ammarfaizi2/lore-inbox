Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWAZBaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWAZBaT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 20:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWAZBaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 20:30:19 -0500
Received: from uproxy.gmail.com ([66.249.92.200]:37780 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932107AbWAZBaR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 20:30:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=McizfwzlBgTVqLDs3ALfTBkAfNdpk8GWvThtC2fRifLDxMgZzRNjHgLCGGJ5k4jpdaPGWSOiFDCwMDisWm92HpE9ya28cwHHMd6vL7twa9V88ayoWcHupoPwUp38iDxMV6yoeyYGIa5HCJKJDX+ry/QFA27KsNVXNNZP3gV8AIU=
Date: Thu, 26 Jan 2006 02:29:41 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: jamie@shareable.org, bernd@firmix.at, vonbrand@inf.utfsm.cl,
       linux-os@analogic.com, diegocg@gmail.com, ram.gupta5@gmail.com,
       mloftis@wgops.com, barryn@pobox.com, a1426z@gawab.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] VM: I have a dream...
Message-Id: <20060126022941.ec79dc47.diegocg@gmail.com>
In-Reply-To: <1138231714.3087.66.camel@mindpipe>
References: <200601240211.k0O28rnn003165@laptop11.inf.utfsm.cl>
	<1138181033.4800.4.camel@tara.firmix.at>
	<20060125150516.GB8490@mail.shareable.org>
	<1138231714.3087.66.camel@mindpipe>
X-Mailer: Sylpheed version 2.1.9 (GTK+ 2.8.9; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 25 Jan 2006 18:28:34 -0500,
Lee Revell <rlrevell@joe-job.com> escribió:

> > Mozilla / Firefox / Opera in particular.  300MB is not funny on a
> > laptop which cannot be expanded beyond 192MB.  Are there any usable
> > graphical _small_ web browsers around?  Usable meaning actually works
> > on real web sites with fancy features.
> 
> "Small" and "fancy features" are not compatible.
> 
> That's the problem with the term "usable" - to developers it means
> "supports the basic core functionality of a web browser" while to users
> it means "supports every bell and whistle that I get on Windows".


That'd be a interesting philosophical (and somewhat offtopic) flamewar:
It's is theorically possible to write a operative system with bells and
whistles for a computer with 200 MB of ram? 200 MB is really a lot of
ram....I'm really surprised at how easy is to write a program that eats
a docen of MB of ram just by showing a window and a few buttons.

In my perfect world, a superhero (say, Linus ;) would analyze and
redesign the whole software stack and would fix it. IMO some parts
of a complete gnu linux system have been accumulating fat with the
time, ej: plan 9's network abstraction could make possible to
kill tons of networking code from lot of apps...
