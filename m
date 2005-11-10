Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751211AbVKJTnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751211AbVKJTnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 14:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVKJTnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 14:43:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751202AbVKJTng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 14:43:36 -0500
Date: Thu, 10 Nov 2005 11:43:24 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Junio C Hamano <junkio@cox.net>
cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] GIT 0.99.9g
In-Reply-To: <Pine.LNX.4.64.0511101128510.4627@g5.osdl.org>
Message-ID: <Pine.LNX.4.64.0511101142370.4627@g5.osdl.org>
References: <7vmzkc2a3e.fsf@assigned-by-dhcp.cox.net> <43737EC7.6090109@zytor.com>
 <7v4q6k1jp0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511101128510.4627@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 10 Nov 2005, Linus Torvalds wrote:
>
> But the point is, that if you actually run fsck every time you want to 
> visualize your pending commits, you're going to feel the pain. 
                 ^^^^^^^

That should be "dangling", of course. 

		Linus
