Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSGQOeX>; Wed, 17 Jul 2002 10:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315167AbSGQOeX>; Wed, 17 Jul 2002 10:34:23 -0400
Received: from mta9n.bluewin.ch ([195.186.1.215]:612 "EHLO mta9n.bluewin.ch")
	by vger.kernel.org with ESMTP id <S315162AbSGQOeW>;
	Wed, 17 Jul 2002 10:34:22 -0400
Date: Wed, 17 Jul 2002 16:35:19 +0200
From: Roger Luethi <rl@hellgate.ch>
To: "O'Riordan, Kevin" <K.ORiordan@ucc.ie>
Cc: "'Joseph Wenninger'" <kernel@jowenn.at>, linux-kernel@vger.kernel.org
Subject: Re: Problem with Via Rhine- Kernel 2.4.18
Message-ID: <20020717143519.GA16992@k3.hellgate.ch>
References: <9FBB394A25826C46B2C6F0EBDAD42755018E6E45@xch2.ucc.ie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9FBB394A25826C46B2C6F0EBDAD42755018E6E45@xch2.ucc.ie>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.4.19-rc1 on i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> in May which fixed the problem and a new patch just a few days ago against
> 2.4.19-rc1(and against 2.4.19-rc2 as well I'd say as the via-rhine driver

Actually, the patch is against Jeff's public tree, which is somewhat
different from what's in rc1, against which I guess the patch will succeed
with offsets (rejecting the changelog portion, which is okay).

You can also try the ac kernel. Alan has the Rhine changes merged since
2.4.19-rc1-ac6.

Roger
