Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbUBDOxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 09:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbUBDOxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 09:53:55 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:7552 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262126AbUBDOxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 09:53:54 -0500
Date: Wed, 4 Feb 2004 15:03:11 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402041503.i14F3Bdq000287@81-2-122-30.bradfords.org.uk>
To: Alastair Stevens <alastair.stevens@mrc-bsu.cam.ac.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <40210578.6000504@mrc-bsu.cam.ac.uk>
References: <40210578.6000504@mrc-bsu.cam.ac.uk>
Subject: Re: Linux 2.6.2 aka "Feisty Dunnart"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Very nice.  But I see the name thing is really official now:
> 
>    2 alastair@gluck:~/linux-2.6> head Makefile
>    VERSION = 2
>    PATCHLEVEL = 6
>    SUBLEVEL = 2
>    EXTRAVERSION =
>    NAME=Feisty Dunnart
> 
> Its own line in the Makefile, no less.  So, no doubt you're planning to 
> actually _use_ this in some devious way?  Worrying indeed....

There was some discussion on the list about dropping version numbers
altogether during 2.7:

http://marc.theaimsgroup.com/?l=linux-kernel&m=107174577415393&w=2

John.
