Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751572AbWFQAWG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbWFQAWG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 20:22:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932492AbWFQAWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 20:22:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49558 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751568AbWFQAWE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 20:22:04 -0400
Date: Fri, 16 Jun 2006 17:22:01 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: Goo GGooo <googgooo@gmail.com>, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: 2.6.17-rc6-mm2
In-Reply-To: <44931AFD.4070809@zytor.com>
Message-ID: <Pine.LNX.4.64.0606161720590.5498@g5.osdl.org>
References: <ef5305790606142040r5912ce58kf9f889c3d61b2cc0@mail.gmail.com> 
 <ef5305790606151814i252c37c4mdd005f11f06ceac@mail.gmail.com> 
 <Pine.LNX.4.64.0606151937360.5498@g5.osdl.org>
 <ef5305790606152249n2702873fy7b708d9c47c78470@mail.gmail.com>
 <Pine.LNX.4.64.0606152335130.5498@g5.osdl.org> <44931AFD.4070809@zytor.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 16 Jun 2006, H. Peter Anvin wrote:
> 
> Perhaps we shouldn't rely on stderr, and instead have a backchannel as part of
> the protocol itself.

Absolutely. I'm just irritated at myself for not going that way in the 
first place, but when I originally wrote it, I had my eyes on other 
issues, and the nice status updates got added later..

		Linus
