Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbTDKO6T (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 10:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbTDKO6T (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 10:58:19 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:51933 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S264385AbTDKO6S (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 10:58:18 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Walt H <waltabbyh@comcast.net>
Subject: Re: 2.4.20-ck5
Date: Sat, 12 Apr 2003 01:11:40 +1000
User-Agent: KMail/1.5.1
References: <3E96D711.70404@comcast.net> <200304120101.32423.kernel@kolivas.org> <3E96D9B5.5060704@comcast.net>
In-Reply-To: <3E96D9B5.5060704@comcast.net>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304120111.40406.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Apr 2003 01:05, you wrote:
> Con Kolivas wrote:
> > XFS must be responsible. I can't test it fully myself but it appears to
> > be related to the latest xfs update I've included in -ck5 which is a
> > snapshot from the sgi website only a week old. Until further notice, use
> > ck4 if you wish to use XFS.
> >
> > Thanks for the feedback.
> >
> > Con
>
> Thanks Con. Now that I think about it, I probably should've cc'd the xfs
> list. There was some work done on memory leaks in XFS recently -
> something in here must expose additional leaks. Thanks again,

No problem. I need the feedback. There is no point cc'ing the xfs list because 
my patch is an altered version so I cant be certain that it's the xfs patch 
or my merging responsible unless you try the patch by itself from their 
website. It's up to you if you have the time and inclination to do this.

Con
