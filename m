Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262694AbTE0G05 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 02:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbTE0G05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 02:26:57 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:60653 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262694AbTE0G05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 02:26:57 -0400
From: dan carpenter <d_carpenter@sbcglobal.net>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [2.5] [Cool stuff] "checking" mode for kernel builds
Date: Mon, 26 May 2003 15:17:04 +0200
User-Agent: KMail/1.5.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       kernel-janitor-discuss@lists.sourceforge.net
References: <Pine.LNX.4.44.0305261728520.15826-100000@home.transmeta.com> <3ED2BE4D.4080005@gmx.net>
In-Reply-To: <3ED2BE4D.4080005@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305261517.05613.d_carpenter@sbcglobal.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 03:24 am, Carl-Daniel Hailfinger wrote:

> > Most people who have used the tool actually like how it forces you to
> > make it very _explicit_ whether you're using a user pointer or not. But I
> > have to admit that I've grown tired of trying to look at all the uses and
> > making sure which sparse warnings are valid and which aren't.
>
> Dan? IIRC you have tools to tackle this issue in a distributed manner.
>
>

Tracking bugs from one version to the next works pretty well for kbugs.org.  
Anyone can moderate the bugs as real or not.  I haven't used sparse script 
yet, but I'll do that tomorrow.  I'd be happy to post the results on 
kbugs.org.  :)

regards,
dan carpenter


