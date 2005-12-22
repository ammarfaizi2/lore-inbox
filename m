Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030238AbVLVRrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030238AbVLVRrK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 12:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030200AbVLVRrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 12:47:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35013 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030180AbVLVRrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 12:47:08 -0500
Date: Thu, 22 Dec 2005 09:46:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: "H. Peter Anvin" <hpa@zytor.com>, Junio C Hamano <junkio@cox.net>,
       git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 1.0.0b quickfix
In-Reply-To: <1135244363.10035.185.camel@gaston>
Message-ID: <Pine.LNX.4.64.0512220945450.4827@g5.osdl.org>
References: <7vpsnq3wrg.fsf@assigned-by-dhcp.cox.net>  <43A9E15F.1060808@zytor.com>
 <1135244363.10035.185.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 22 Dec 2005, Benjamin Herrenschmidt wrote:
> > 
> > Wouldn't it make more sense for the maintenance release to be 1.0.1?
> 
> Seconded. letters in versions are bad. With my MacOS background, for me,
> "b" means "beta" :)

FWIW, thirded. The kernel used to use letters too, and it's cute, but just 
using multiple levels of release numbers is much more common.

		Linus
