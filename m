Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751299AbVH2SsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbVH2SsT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbVH2SsT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:48:19 -0400
Received: from vena.lwn.net ([206.168.112.25]:52437 "HELO lwn.net")
	by vger.kernel.org with SMTP id S1751299AbVH2SsS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:48:18 -0400
Message-ID: <20050829184818.3305.qmail@lwn.net>
To: Nick Warne <nick@linicks.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13 new option timer frequency 
From: corbet@lwn.net (Jonathan Corbet)
In-reply-to: Your message of "Mon, 29 Aug 2005 18:57:15 BST."
             <200508291857.15746.nick@linicks.net> 
Date: Mon, 29 Aug 2005 12:48:18 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I built and installed 2.6.13 today, and oldconfig revealed the new option for 
> timer frequency.
> 
> I searched the LKML on this, but all I found is the technical stuff - not 
> really any layman solutions.

I wrote a bit about the timer frequency option a few weeks ago:

	http://lwn.net/Articles/145973/

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
