Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267350AbUHTN4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267350AbUHTN4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267553AbUHTN4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:56:25 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:20817 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267350AbUHTNzy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:55:54 -0400
Message-ID: <d577e56904082006553eefad5@mail.gmail.com>
Date: Fri, 20 Aug 2004 09:55:54 -0400
From: Patrick McFarland <diablod3@gmail.com>
Reply-To: Patrick McFarland <diablod3@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       kernel@wildsau.enemy.org, fsteiner-mail@bio.ifi.lmu.de,
       b.zolnierkiewicz@elka.pw.edu.pl
In-Reply-To: <4125FFA2.nail8LD61HFT4@burner>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
 <4124BA10.6060602@bio.ifi.lmu.de>
 <1092925942.28353.5.camel@localhost.localdomain>
 <200408191800.56581.bzolnier@elka.pw.edu.pl>
 <4124D042.nail85A1E3BQ6@burner>
 <1092938348.28370.19.camel@localhost.localdomain> <4125FFA2.nail8LD61HFT4@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Aug 2004 15:41:54 +0200, Joerg Schilling
<schilling@fokus.fraunhofer.de> wrote:
> Unless you tell us what kind of "security holes" you found _and_ when this has
> been, it looks like a meaningless remark.

Face it, you think anything anyone says (including Alan, Linus, me,
and anyone else who happens by) anything about your precious cdrtools
is making meaningless remarks. Allowing users to fuck hardware using a
badly written permissions system _is_ a security hole, no matter how
much you dance around the issue.

This is why Linus added what he did, so users couldn't; which means
_fix your damn program and quit your bitching_.

-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids, we'd 
all be running around in darkened rooms, munching magic pills and listening to
repetitive electronic music." -- Kristian Wilson, Nintendo, Inc, 1989
