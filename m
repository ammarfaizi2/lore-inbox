Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTFCTCs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 15:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbTFCTCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 15:02:47 -0400
Received: from ip-64-7-1-79.dsl.lax.megapath.net ([64.7.1.79]:47839 "EHLO
	ip-64-7-1-79.dsl.lax.megapath.net") by vger.kernel.org with ESMTP
	id S262369AbTFCTCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 15:02:47 -0400
Date: Tue, 3 Jun 2003 12:15:56 -0700 (PDT)
From: <lk@trolloc.com>
X-X-Sender: <bpape@ip-64-7-1-79.dsl.lax.megapath.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc7
In-Reply-To: <Pine.LNX.4.55L.0306031506500.2105@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0306031214140.22989-100000@ip-64-7-1-79.dsl.lax.megapath.net>
X-keyboard: Happy Hacking Keyboard Lite
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Now I really hope its the last one, all this rc's are making me mad.
> >
> > Are you quite sure you don't want Alan to get you the updates necessary
> > for IDE to build as modules for .21 final?
> 
> Well, I can for sure release -rc8 with that.
> 
> I just want this possible -rc8 to be released no later than tonight.

Unfortunately I just committed my test box to production and can't test 
Alan's SiImage fixes in rc6-ac2, but if they pan out, please try to 
include them in -rc8 as well.


