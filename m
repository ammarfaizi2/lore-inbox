Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316574AbSILQ14>; Thu, 12 Sep 2002 12:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSILQ1z>; Thu, 12 Sep 2002 12:27:55 -0400
Received: from packet.digeo.com ([12.110.80.53]:44732 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S316574AbSILQ1w>;
	Thu, 12 Sep 2002 12:27:52 -0400
Message-ID: <3D80C540.B44AAFD@digeo.com>
Date: Thu, 12 Sep 2002 09:48:00 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: Rick Lindsley <ricklind@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] sard changes for 2.5.34
References: <3D804036.4C000672@digeo.com> <Pine.LNX.4.44L.0209121314440.1857-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Sep 2002 16:32:34.0959 (UTC) FILETIME=[FFD691F0:01C25A79]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Thu, 12 Sep 2002, Andrew Morton wrote:
> 
> > b).  Let's get the kernel right and change userspace to follow.  We have
> > another accounting patch which breaks top(1), so Rik has fixed it (and
> > is feeding the fixes upstream).
> 
> Speaking of which, what happened to the iowait patch ?

I need to add a few words to Documentation/Changes and reintegrate it.

> Did you merge it with Linus or did it fall between the cracks ?

I don't have cracks ;)  Not enough patches far that.
