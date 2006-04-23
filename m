Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWDWFxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWDWFxJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 01:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWDWFxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 01:53:08 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:25307
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751325AbWDWFxH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 01:53:07 -0400
Date: Sat, 22 Apr 2006 22:53:09 -0700 (PDT)
Message-Id: <20060422.225309.108888215.davem@davemloft.net>
To: bert.hubert@netherlabs.nl
Cc: simlo@phys.au.dk, linux-kernel@vger.kernel.org, mingo@elte.hu,
       netdev@vger.kernel.org
Subject: Re: Van Jacobson's net channels and real-time
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20060422193024.GA29040@outpost.ds9a.nl>
References: <Pine.LNX.4.44L0.0604201819040.19330-100000@lifa01.phys.au.dk>
	<20060420.120955.28255828.davem@davemloft.net>
	<20060422193024.GA29040@outpost.ds9a.nl>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: bert hubert <bert.hubert@netherlabs.nl>
Date: Sat, 22 Apr 2006 21:30:24 +0200

> On Thu, Apr 20, 2006 at 12:09:55PM -0700, David S. Miller wrote:
> > Going all the way to the socket is a large endeavor and will require a
> > lot of restructuring to do it right, so expect this to take on the
> > order of months.
> 
> That's what you said about Niagara too :-) 

I'm just trying to keep the expectations low so it's easier
to exceed them :-)
