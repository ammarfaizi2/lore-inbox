Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWAFVqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWAFVqH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 16:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWAFVqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 16:46:07 -0500
Received: from zproxy.gmail.com ([64.233.162.193]:27304 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751129AbWAFVqG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 16:46:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UwNqjrT88gdiXRaGIozERzAV+XeF93PY0XtY3+BBfsd1SzEVVOVhydIFtyn+Mc9eEG3KQU8+pw4Ua/P58JpXewa8T6GGmSJ5LvhCKyQYTIpYq2mVXkaRZXBILvGK5W/tY24ZSTNYLajbRuAQxQs4yECEJlbHDiXSOzxKleoP4Yw=
Message-ID: <5a4c581d0601061346u9768717rc99f74dd2473f493@mail.gmail.com>
Date: Fri, 6 Jan 2006 22:46:02 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Subject: Re: 2.6.15-git2: CONFIGFS_FS shows up as M/y choice, help says "if unsure, say N"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20060106213950.GA26581@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a4c581d0601061310j3f4eb310o1d68c0b87c278685@mail.gmail.com>
	 <20060106213950.GA26581@csclub.uwaterloo.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/06, Lennart Sorensen <lsorense@csclub.uwaterloo.ca> wrote:
> On Fri, Jan 06, 2006 at 10:10:13PM +0100, Alessandro Suardi wrote:
> > ===========
> > Userspace-driven configuration filesystem (EXPERIMENTAL) (CONFIGFS_FS)
> > [M/y/?] (NEW)
> >
> > Both sysfs and configfs can and should exist together on the
> > same system. One is not a replacement for the other.
> >
> > If unsure, say N.
> > ===========
> >
> > I think I'll say M - for now ;)
>
> Sure, if you want to play with configfs you should.  Most users probably
> have no interest in helping develop/debug it, so the decomendation makes
> perfect sense.

--alessandro

 "Somehow all you ever need is, never really quite enough, you know"

   (Bruce Springsteen - "Reno")
