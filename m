Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTE3Qdg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 12:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTE3Qdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 12:33:35 -0400
Received: from ip68-3-49-116.ph.ph.cox.net ([68.3.49.116]:43905 "EHLO
	raq.home.iceblink.org") by vger.kernel.org with ESMTP
	id S263805AbTE3Qde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 12:33:34 -0400
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Tomas Szepe <szepe@pinerecords.com>, kwijibo@zianet.com,
       linux-kernel@vger.kernel.org
Subject: Re: 21rc6 serverworks IDE blows even more than is usual :)
References: <20030529114001.GD7217@louise.pinerecords.com> <20030529114001.GD7217@louise.pinerecords.com> <20030530121108.6a6a82de.skraw@ithnet.com>
Message-ID: <oprpzvr4xuury4o7@lists.bilicki.com>
Content-Type: text/plain; charset=utf-8; format=flowed
From: Duncan Laurie <duncan@sun.com>
MIME-Version: 1.0
Date: Fri, 30 May 2003 09:51:30 -0700
User-Agent: Opera7.11/Linux M2 build 406
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 May 2003 12:11:08 +0200, Stephan von Krawczynski <skraw@ithnet.com> wrote:
>
> I don't know if this is in anyway interesting for you, but I got the same
> chipset on an Asus board and been burning GBs of data onto DVDs with it and no
> (ide) problem.
>

Its interesting to me.. It probably means my original diagnosis that this
was a bad chip revision is unfounded and maybe it can be fixed with the
right settings.  Could I get an lspci -xxx for devices 00:0f.0 and 00:0f.1
from your box as well so I can cross-ref it with the broken ones?

-duncan

