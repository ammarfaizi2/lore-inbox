Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVKINcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVKINcg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 08:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750752AbVKINcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 08:32:36 -0500
Received: from vena.lwn.net ([206.168.112.25]:63978 "HELO lwn.net")
	by vger.kernel.org with SMTP id S1750751AbVKINcf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 08:32:35 -0500
Message-ID: <20051109133235.3099.qmail@lwn.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: userspace block driver? 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Wed, 09 Nov 2005 02:27:41 EST."
             <4371A4ED.9020800@pobox.com> 
Date: Wed, 09 Nov 2005 06:32:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Has anybody put any thought towards how a userspace block driver would work?

I know Peter Chubb and the Gelato folks have.  Some info is at
http://www.gelato.unsw.edu.au/IA64wiki/UserLevelDrivers.  Mostly it says
that the block interface "needs to be cleaned up," and I think it has
been in that state for years.  Still, it might be a starting place.

jon
