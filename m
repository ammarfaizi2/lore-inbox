Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261486AbTI3MvJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 08:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbTI3MvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 08:51:09 -0400
Received: from quechua.inka.de ([193.197.184.2]:32422 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261486AbTI3Mrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 08:47:39 -0400
Subject: Re: ide problem in newer kernel or disc failure
From: Andreas Jellinghaus <aj@dungeon.inka.de>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200309301357.15548.bzolnier@elka.pw.edu.pl>
References: <1064881613.811.8.camel@simulacron>
	 <200309301357.15548.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Message-Id: <1064926083.2511.4.camel@simulacron>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 30 Sep 2003 14:48:04 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2003-09-30 at 13:57, Bartlomiej Zolnierkiewicz wrote:
> On Tuesday 30 of September 2003 02:26, Andreas Jellinghaus wrote:
> > Hi,
> >
> > my disc starts showing problems. a few weeks ago it was fine.
> > could that be a problem with latest 2.6.0-test* kernels
> > or is my disc failing?
> 
> <...>
> 
> Looks like a failing disk (errors logged by SMART).

thanks. however I wonder: smart extended test does not
find any error, and this morning the disc was fine again.

the machine was turned off, and it's a laptop. so could this
be related to temperature or something like that? 

Regards, Andreas

