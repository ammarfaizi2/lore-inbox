Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVBOJ2c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVBOJ2c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 04:28:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbVBOJ2c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 04:28:32 -0500
Received: from gate.firmix.at ([80.109.18.208]:57818 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S261659AbVBOJ2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 04:28:30 -0500
Subject: Re: [OT] speeding boot process
From: Bernd Petrovitsch <bernd@firmix.at>
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Cc: lgb@lgb.hu, Kyle Moffett <mrmacman_g4@mac.com>,
       Lee Revell <rlrevell@joe-job.com>,
       Patrick McFarland <pmcfarland@downeast.net>,
       linux-kernel@vger.kernel.org, Tim Bird <tim.bird@am.sony.com>,
       Prakash Punnoor <prakashp@arcor.de>,
       linux-hotplug-devel@lists.sourceforge.net, Greg KH <gregkh@suse.de>,
       Roland Dreier <roland@topspin.com>
In-Reply-To: <4d8e3fd305021500346503585b@mail.gmail.com>
References: <20050211011609.GA27176@suse.de>
	 <4d8e3fd305021400323fa01fff@mail.gmail.com> <42106685.40307@arcor.de>
	 <1108422240.28902.11.camel@krustophenia.net> <524qge20e2.fsf@topspin.com>
	 <1108424720.32293.8.camel@krustophenia.net> <42113F6B.1080602@am.sony.com>
	 <1108430245.32293.16.camel@krustophenia.net>
	 <4B923A81-7EF3-11D9-86CC-000393ACC76E@mac.com>
	 <20050215073222.GB26950@vega.lgb.hu>
	 <4d8e3fd305021500346503585b@mail.gmail.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1108459672.438.3.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.5.5 
Date: Tue, 15 Feb 2005 10:27:52 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-15 at 09:34 +0100, Paolo Ciarrocchi wrote:
[...]
> So... why is Gentoo the only distro the uses parallel execution of
> init scripts ?

Because no other distro bothered to implement it.

Apart from that we as quite far off-topic for LKML since this has
nothing to do with kernel.
The only reason getting this on-topic is to try to get the best SWSUSP
support in the kernel so one simply does not need this.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

