Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbVILXZ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbVILXZ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 19:25:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbVILXZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 19:25:29 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:44725 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932354AbVILXZ2 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 19:25:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NZR8dJGnbDVQwElvkzLyNsgwkRO57b4zKmJqvZoY9EWAOzUammN/7DNVoqkiGnhIwZKVLHw1P5CZwQORtj51DN0IezAx6JbiYLeqeXPxVF7CupQwbIQ9saWifs/8mcYn7H+n+hI3ejSoZ3cqHcG+HObEefDpeMLex7UDLGqRk+c=
Message-ID: <d120d500050912162546777a7b@mail.gmail.com>
Date: Mon, 12 Sep 2005 18:25:24 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Andrea Arcangeli <andrea@cpushare.com>
Subject: Re: git tag in localversion
Cc: linux-kernel@vger.kernel.org, klive@cpushare.com,
       Ian Wienand <ianw@gelato.unsw.edu.au>, Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20050912222137.GP13439@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050912210836.GL13439@opteron.random>
	 <d120d5000509121431765f52c8@mail.gmail.com>
	 <20050912222137.GP13439@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/05, Andrea Arcangeli <andrea@cpushare.com> wrote:
> On Mon, Sep 12, 2005 at 04:31:24PM -0500, Dmitry Torokhov wrote:
> > I think this question better be addressed to Ian or Sam (Andrea, did
> > you pick a wrong entry from your address book?), adding them to CC...
> 
> hmm, if you're not the right person it means hg log -p has some
> problem... this changeset was submitted by you according to mercurial.
> 
> http://kernel.org/hg/linux-2.6/?cmd=changeset;node=3c0ba37caa9aa696f87eaaee6ccd2a70aba78034
> 

This is just a merge changeset. I was pulling from Linus and there
were conflicts so I had to do manual merge and apparently this is what
was produced.

-- 
Dmitry
