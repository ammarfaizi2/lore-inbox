Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273015AbTHFMWT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 08:22:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273016AbTHFMWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 08:22:19 -0400
Received: from www.13thfloor.at ([212.16.59.250]:11679 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S273015AbTHFMWS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 08:22:18 -0400
Date: Wed, 6 Aug 2003 14:22:28 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: chet@cwru.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: ulimit weirdness ...
Message-ID: <20030806122228.GA5206@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: chet@cwru.edu, linux-kernel@vger.kernel.org
References: <20030802141335.GB17311@www.13thfloor.at> <030805133903.AA82568.SM@nike.ins.cwru.edu> <20030805154454.GA6688@www.13thfloor.at> <030805160255.AA82997.SM@nike.ins.cwru.edu> <20030805162532.GA12828@www.13thfloor.at> <030805175329.AA83189.SM@nike.ins.cwru.edu> <20030805223129.GA2594@www.13thfloor.at> <030806121410.AA86281.SM@nike.ins.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <030806121410.AA86281.SM@nike.ins.cwru.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 08:14:10AM -0400, Chet Ramey wrote:
> > but as my email tried to point out, the kernel people
> > do think that this should be handled by the program
> > setting the limits, and in this particular case, bash
> > is the program setting the limits ...
> 
> I guess the kernel people and I will have to agree to disagree.
> It will not be the first time.

okay, thanks,

maybe it _is_ time to write a standalone
ulimit, which handles the kernel attitudes
more generous (read: user friendly) ...

best,
Herbert

> -- 
> ``The lyf so short, the craft so long to lerne.'' - Chaucer
> ( ``Discere est Dolere'' -- chet )
> 						Live...Laugh...Love
> Chet Ramey, ITS, CWRU    chet@po.CWRU.Edu    http://cnswww.cns.cwru.edu/~chet/
