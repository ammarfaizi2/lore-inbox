Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292957AbSDDSlp>; Thu, 4 Apr 2002 13:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293161AbSDDSlb>; Thu, 4 Apr 2002 13:41:31 -0500
Received: from zero.tech9.net ([209.61.188.187]:12551 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292957AbSDDSkx>;
	Thu, 4 Apr 2002 13:40:53 -0500
Subject: Re: [patch] kjournald locking fix
From: Robert Love <rml@tech9.net>
To: "Ishan O. Jayawardena" <ioshadij@hotmail.com>
Cc: marcelo@conectiva.com.br, akpm@zip.com.au, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0204041643400.1396-200000@shalmirane.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 04 Apr 2002 13:40:46 -0500
Message-Id: <1017945647.22304.477.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-04 at 17:55, Ishan O. Jayawardena wrote:

> 	Here's an improved version of my previous patch. Thanks to Andrew
> Morton for the advice. 2.5 needs this too I think, since preemption is
> part of it now...

I already sent a fix of my own to Linus last night, so 2.5 is covered.

	Robert Love

