Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbVHRRxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbVHRRxk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 13:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932375AbVHRRxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 13:53:39 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4003 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S932365AbVHRRxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 13:53:38 -0400
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Lee Revell <rlrevell@joe-job.com>
To: Akira Tsukamoto <akira-t@suna-asobi.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050818002425.6E90.AKIRA-T@suna-asobi.com>
References: <98df96d305081622107ca969f@mail.gmail.com>
	 <20050817233001.6E7C.AKIRA-T@suna-asobi.com>
	 <20050818002425.6E90.AKIRA-T@suna-asobi.com>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 13:53:35 -0400
Message-Id: <1124387615.5973.28.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.7 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-08-18 at 00:27 +0900, Akira Tsukamoto wrote:
> My computer with Athlon K7 was faster with manually prefetching,
> but I did not know it is already becoming obsolete.
> 

Don't listen to people who tell you $FOO hardware is obsolete, they have
a very narrow view.  "Obsolete" is meaningless except in reference to
some specific application.  The 386 is obsolete on the desktop but still
common on the embedded market.

Lee

