Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbTI3Nru (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 09:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbTI3Nru
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 09:47:50 -0400
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:23540 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261491AbTI3Nrs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 09:47:48 -0400
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "kartikey bhatt" <kartik_me@hotmail.com>, diegocg@teleline.es
Subject: Re: Can't X be elemenated?
Date: Tue, 30 Sep 2003 08:34:12 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
References: <Law11-F60EhrkMNYwoy0001cb7a@hotmail.com>
In-Reply-To: <Law11-F60EhrkMNYwoy0001cb7a@hotmail.com>
MIME-Version: 1.0
Message-Id: <03093008341200.16194@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 30 September 2003 03:09, kartikey bhatt wrote:
> your graphics card (hw) is resource that needs to be managed by OS.
> leaving it to 3rd party developers is an *adhoc* solution, *a stark immoral
> choice*.
> my friend gotta new AMD athlon with nvidia gforce 32mb shared memory,

Nvidia doesn't support Linux.

> but he is on the mercy of X people to get full support for it.

Nvidia doesn't support X either.

> for now he has to do with generic i810 driver?
> any answer for that.

The problem with nvidia is that they will NOT release information on 
programming their graphics board.

Without the information, no code.
No code, no driver.
No driver, no support.

Want a fix? talk to nvidia.

> my question is can't X be eleminated by providing support for
> graphics drivers and other routines at kernel  level?

Sure - Already has been done.

There IS a framebuffer implementation of graphics display. And X already
supports it.

If you are talking about nvidia support.... talk to nvidia.
