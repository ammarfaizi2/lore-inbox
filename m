Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751500AbWCHBkA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbWCHBkA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 20:40:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbWCHBkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 20:40:00 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:3790 "EHLO
	suzuka.mcnaught.org") by vger.kernel.org with ESMTP
	id S1751500AbWCHBkA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 20:40:00 -0500
To: Lee Revell <rlrevell@joe-job.com>
Cc: Matthias Andree <matthias.andree@gmx.de>,
       Silviu Marin-Caea <silviu_marin-caea@fieldinsights.ro>,
       opensuse-factory@opensuse.org, linux-kernel@vger.kernel.org
Subject: Re: [opensuse-factory] Re[2]: 2.6.16 serious consequences /
 GPL_EXPORT_SYMBOL / USB drivers of major vendor excluded
References: <OF2725219B.50D2AC48-ONC1257129.00416F63-C1257129.00464A42@avm.de>
	<200603070942.31774.silviu_marin-caea@fieldinsights.ro>
	<1141769422.767.99.camel@mindpipe>
	<20060307233724.GB13357@merlin.emma.line.org>
	<1141779307.767.107.camel@mindpipe>
From: Douglas McNaught <doug@mcnaught.org>
Date: Tue, 07 Mar 2006 20:39:59 -0500
In-Reply-To: <1141779307.767.107.camel@mindpipe> (Lee Revell's message of
 "Tue, 07 Mar 2006 19:55:06 -0500")
Message-ID: <871wxdk93k.fsf@suzuka.mcnaught.org>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> writes:

> I didn't mean to imply that, I was just pointing out it's another
> feature available in userspace that can't be used in the kernel.  Audio
> stuff like the AC3 encoder/decoders I've seen in Windows drivers use
> floating point instructions for example.

It's also a lot easier to use Altivec/SSE/whatever instructions in
userspace, if you've got 'em...

-Doug
