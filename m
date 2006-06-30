Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932089AbWF3Iqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbWF3Iqt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 04:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWF3Iqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 04:46:49 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:9960 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932089AbWF3Iqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 04:46:48 -0400
Date: Fri, 30 Jun 2006 12:46:30 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: "Chandra S. Seetharaman" <sekharan@us.ibm.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Michael Kerrisk <michael.kerrisk@gmx.net>,
       Albert Cahalan <acahalan@gmail.com>
Subject: Re: [RFC][PATCH 3/3] Process events biarch bug: New process events connector value
Message-ID: <20060630084630.GA27593@2ka.mipt.ru>
References: <20060627112644.804066367@localhost.localdomain> <1151408975.21787.1815.camel@stark> <1151435679.1412.16.camel@linuxchandra> <1151444382.21787.1858.camel@stark> <20060628055326.GB12276@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060628055326.GB12276@2ka.mipt.ru>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Fri, 30 Jun 2006 12:46:42 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
>I haven't yet seen a good explanation of what this is or does,
>but I suspect it may be useful for the "top" program or for a
>debugger. In either case, I am a highly interested party.
>I maintain top as part of the procps package. People pay me to
>hack on debuggers.

>Mind pointing me to some documentation and an explanation of why
>the feature was added? Is there a man page? (there should be)

There are a lot of goodies for process accounting there.
One can find initial draft with detailed description of the project 
goals at http://lwn.net/Articles/153694/

-- 
	Evgeniy Polyakov
