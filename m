Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTI1QBc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Sep 2003 12:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262601AbTI1QBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Sep 2003 12:01:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:4490 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262598AbTI1QBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Sep 2003 12:01:30 -0400
Date: Sun, 28 Sep 2003 18:01:44 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Gabor MICSKO <gmicsko@szintezis.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exec-shield-2.6.0-test6-G3
In-Reply-To: <1064761054.29997.39.camel@sunshine>
Message-ID: <Pine.LNX.4.56.0309281756530.17030@localhost.localdomain>
References: <1064761054.29997.39.camel@sunshine>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 28 Sep 2003, Gabor MICSKO wrote:

> I`ve made a port of the Ingo's last exec-shield patch. This is my second
> patch, so please test this one carefully.
> 
> Against vanilla 2.6.0-test6:

the test5-bk12 one applied cleanly to 2.6.0-test6 (except a Makefile
reject), and i've renamed it to test6-G3 yesterday. Here is the full list
of exec-shield patches:

  redhat.com/~mingo/exec-shield/exec-shield-2.6.0-test6-G3

  redhat.com/~mingo/exec-shield/exec-shield-2.4.22-G3

  redhat.com/~mingo/exec-shield/exec-shield-2.4.22-ac1-nptl-G3

	Ingo
