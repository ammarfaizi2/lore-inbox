Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261952AbVGUXSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261952AbVGUXSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 19:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVGUXSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 19:18:54 -0400
Received: from rproxy.gmail.com ([64.233.170.200]:5683 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261952AbVGUXSx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 19:18:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ijDbCvh3nAUW6I31OsEqc9Gv2PWileBTH1HwEhCHpLrifn+59fcY3WpfmHtYwCUiq2db5gNJpr4tkATqgnBKGQRjJMLoRBZAeKxPuIUwTHNWqG/i0z4L2Z8RGaHI0PmEx4uWM/6K+YT27Y3sEAQacOg0bSlbH2i44j/9yqa/yLk=
Message-ID: <21d7e9970507211618eadc8d0@mail.gmail.com>
Date: Fri, 22 Jul 2005 09:18:53 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc3-mm1 - breaks DRI
Cc: Ed Tomlinson <tomlins@cam.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20050722015613.67a32450.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050715013653.36006990.akpm@osdl.org>
	 <200507210737.41539.tomlins@cam.org>
	 <20050722015613.67a32450.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >>
> >> I also use 2.6.13-rc3-mm1.  Will try with a previous version an report to lkml if
> >> it works.
> >>
> >
> > I just tried 13-rc2-mm1 and dri is working again. Its reported to also work
> > with 13-rc3.
> 

Hmm no idea what could have broken it, I'm at OLS and don't have any
DRI capable machine here yet.. so it'll be a while before I get to
take a look at it .. I wouldn't be terribly surprised if some of the
new mapping code might have some issues..

Dave.
