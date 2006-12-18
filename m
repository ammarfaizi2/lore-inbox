Return-Path: <linux-kernel-owner+w=401wt.eu-S1754113AbWLRPBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113AbWLRPBK (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 10:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754115AbWLRPBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 10:01:10 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49849 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754113AbWLRPBJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 10:01:09 -0500
Date: Mon, 18 Dec 2006 16:00:48 +0100
From: Karel Zak <kzak@redhat.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Arkadiusz Miskiewicz <arekm@maven.pl>
Cc: linux-kernel@vger.kernel.org, Henne Vogelsang <hvogel@suse.de>,
       Olaf Hering <olh@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: util-linux: orphan
Message-ID: <20061218150048.GA11005@petra.dvoda.cz>
References: <20061218075210.GB5217@petra.dvoda.cz> <200612181055.05585.arekm@maven.pl> <20061109224157.GH4324@petra.dvoda.cz> <20061218071737.GA5217@petra.dvoda.cz> <Pine.LNX.4.61.0612181031210.21739@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612181055.05585.arekm@maven.pl> <Pine.LNX.4.61.0612181031210.21739@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 18, 2006 at 10:33:33AM +0100, Jan Engelhardt wrote:
> 
> > after few weeks I'm pleased to announce a new "util-linux-ng" project. This
> > project is a fork of the original util-linux (2.13-pre7). 
> >
> > The goal of the project is to move util-linux code back to useful state, sync
> > with actual distributions and kernel and make development more transparent end
> > open.
> 
> If Adrian [ http://lkml.org/lkml/2006/11/9/262 ] does not want to be
> the maintainer, ask if you can take over, including the name.

On Mon, Dec 18, 2006 at 10:55:05AM +0100, Arkadiusz Miskiewicz wrote:
> On Monday 18 December 2006 08:52, Karel Zak wrote:
> >  I'm pleased to announce a new "util-linux-ng" project. This project
> >  is a fork of the original util-linux (2.13-pre7).
> 
> Fork? Are you saying that you just didn't take over maintainership and now we 
> will have two versions of util-linux!? :/

 People around util-linux-ng are not so naive ;-)
 
 We spent last month with discussion about a way how (non-)fork this
 project. We made decision that a fork is the right way, because
 Adrian Bunk completely ignores __everyone__ who wants to talk with
 him about utils-linux.

 A fork is nothing attractive, but it's also a way how improve things
 in Open Source world.

 The goal is not only improve source code, but also a way how this
 project is maintained (mailing list, discussion about changes, git,
 transparent development, ...).

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
