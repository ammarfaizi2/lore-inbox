Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262859AbUKXUkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbUKXUkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 15:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbUKXUkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 15:40:10 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:42418 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262849AbUKXUiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 15:38:18 -0500
Subject: Re: Isolating two network processes on same machine
From: Lee Revell <rlrevell@joe-job.com>
To: linux-os@analogic.com
Cc: Ole Laursen <olau@cs.aau.dk>, linux-kernel@vger.kernel.org,
       d507a@cs.aau.dk
In-Reply-To: <Pine.LNX.4.61.0411241113090.19813@chaos.analogic.com>
References: <tv8r7mj1dwr.fsf@homer.cs.aau.dk>
	 <Pine.LNX.4.61.0411241113090.19813@chaos.analogic.com>
Content-Type: text/plain
Date: Wed, 24 Nov 2004 11:38:16 -0500
Message-Id: <1101314296.1761.18.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-11-24 at 11:23 -0500, linux-os wrote:
> I was going to say, set the netmask small enough so that both
> machines are on different networks and set default routes to
> your gateway.... But there is a bug somewhere that doesn't
> allow a netmask of anything but 0 in the last byte.
> 

Really?  That would be a horrible bug.  How about some references?

Lee

