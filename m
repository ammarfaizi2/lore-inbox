Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSHITFA>; Fri, 9 Aug 2002 15:05:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSHITFA>; Fri, 9 Aug 2002 15:05:00 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:42408 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S315454AbSHITE7>; Fri, 9 Aug 2002 15:04:59 -0400
Subject: Re: Announce: daily 2.5 BK snapshots
From: Paul Larson <plars@austin.ibm.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1505209847.1028881191@[10.10.2.3]>
References: <1028903778.19435.348.camel@plars.austin.ibm.com> 
	<1505209847.1028881191@[10.10.2.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Aug 2002 14:03:00 -0500
Message-Id: <1028919780.22405.353.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 10:19, Martin J. Bligh wrote:
> Personally, I'd love to see the *changes* in what passed and failed
> posted every day - the whole result set is obviously too big. The 
> quicker people know what's wrong, the quicker it gets fixed, before
> we build more on top of an unstable foundation.
Right, that's the plan.  If something changes from one day to the next,
then it will be submitted immediatly.  Right now I'm in that stage of
building a "stable" foundation.  It could probably use some tweaking to
the .config and other things to introduce a higher likelyhood of finding
problems from one day to the next, but I don't want to be constantly
just finding things that everyone is already aware of.  Any suggestions
wrt this are welcome.

-Paul Larson

