Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266458AbUAVWnx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 17:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266461AbUAVWnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 17:43:53 -0500
Received: from bdsl.66.12.153.218.gte.net ([66.12.153.218]:55230 "EHLO
	scottstuff.net") by vger.kernel.org with ESMTP id S266458AbUAVWnw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 17:43:52 -0500
To: david.lang@digitalinsight.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Confirmation Spam Blocking was: List 'linux-dvb' closed to
 public posts
In-Reply-To: <Pine.LNX.4.58.0401221034090.4548@dlang.diginsite.com>
References: <ecartis-01212004203954.14209.1@mail.convergence2.de>
 <20040121194315.GE9327@redhat.com> <Pine.LNX.4.58.0401211155300.2123@home.osdl.org>
 <1074717499.18964.9.camel@localhost.localdomain> <20040121211550.GK9327@redhat.com>
 <20040121213027.GN23765@srv-lnx2600.matchmail.com>
 <pan.2004.01.21.23.40.00.181984@dungeon.inka.de> <1074731162.25704.10.camel@localhost.localdomain>
 <yq0hdyo15gt.fsf@wildopensource.com> <401000C1.9010901@blue-labs.org>
From: scott@sigkill.org (Scott Laird)
Message-ID: <courier.40105225.00004878@scottstuff.net>
Date: Thu, 22 Jan 2004 14:43:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.58.0401221034090.4548@dlang.diginsite.com> you write:
>
>so we need to extend the Bayesian filters to deal with multi-word combos,
>how many legit mail has those dictionary words in them? properly traind
>their presence should help identify the spam.

Been there, done that.  Take a look at spamprobe, it does two-word
bayes and is freakishly effective.  I haven't had a single false
positive since the first week of training, and it's blocking well over
99% of all incoming spam.  I no longer have a spam problem.


Scott
