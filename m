Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTECOIL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 May 2003 10:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263317AbTECOIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 May 2003 10:08:11 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51007 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S263315AbTECOIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 May 2003 10:08:10 -0400
To: Scott Robert Ladd <coyote@coyotegulch.com>
Cc: John Bradford <john@grabjohn.com>, Bill Davidsen <davidsen@tmr.com>,
       Hanna Linder <hannal@us.ibm.com>, jw schultz <jw@pegasys.ws>,
       lse-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LSE conference call
References: <200304251826.h3PIQMNg001890@81-2-122-30.bradfords.org.uk>
	<3EB28FC2.6070305@coyotegulch.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 May 2003 08:17:26 -0600
In-Reply-To: <3EB28FC2.6070305@coyotegulch.com>
Message-ID: <m1ade4cdxl.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Robert Ladd <coyote@coyotegulch.com> writes:

> John Bradford wrote:
> > Ah, but assuming that you had a compass to calculate the local time
> > offset, (ignoring DST), anyway, you could have used that to calculate
> > the _local_ time without looking at your watch at all ;-).  However,
> > you wouldn't be able to calculate the timezone you were in.
> 
> Ah, but if you had a GPS system available, and a database of time zone
> boundaries, you could adjust on-the-fly for different jurisdictions. I've dones
> somethign of the sort recently for a client; the main problem lies in the
> accuracy (and size) of the database. Indiana, for example, presents unique
> challenges, with its patchwork implementation of DST...

Indiana doesn't do DST.  But it is true that people on the edges of the state
like to know what time it is for their neighbors across the border.  

I suspect the border case is at least slightly true for other places right
on the border between timezones, as well.    Though I can't think of any other
examples right now.

Eric
