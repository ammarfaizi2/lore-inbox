Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbTLJORf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 09:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263592AbTLJORf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 09:17:35 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:27895 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S262986AbTLJORd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 09:17:33 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Paul Zimmerman" <zimmerman.paul@comcast.net>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux GPL and binary module exception clause?
Date: Wed, 10 Dec 2003 08:17:10 -0600
X-Mailer: KMail [version 1.2]
References: <000701c3be1c$8a3cfbc0$0301a8c0@comcast.net>
In-Reply-To: <000701c3be1c$8a3cfbc0$0301a8c0@comcast.net>
MIME-Version: 1.0
Message-Id: <03121008171001.31567@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 December 2003 00:20, Paul Zimmerman wrote:
> [ Date:  Sometime in the near future. ]
>
[snip]
>
> [ Cut to:  Bedroom of a comfortable house in the suburbs.  Nighttime. ]
>
> [ Linus - suddenly sits bolt upright in the bed, a horrified expression on
> his face: ]  "AAAAiiiiiiieeeeeeeeaaaaaaarrrrrrgggggghhhhhh!!!!"
>
> [ Wife - shaking Linus' shoulder: ]  "Honey, wake up, wake up!  I think
> you're having that horrible nightmare again!"
>
> And that is why binary drivers will always be allowed under Linux.

If that were the problem, then the kernel would be LGPL, and not GPL. LGPL
permits linking (shared libraries), GPL doesn't. To me, it boils down to:

Link with GPL -> result is GPL.
Link with LGPL shared libraries -> result may be anything.
