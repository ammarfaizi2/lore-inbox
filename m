Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268275AbUHQO1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268275AbUHQO1J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 10:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268258AbUHQO1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 10:27:08 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:24808 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268269AbUHQOYQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 10:24:16 -0400
Subject: Re: Coding style: do_this(a,b) vs. do_this(a, b)
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: pavel@ucw.cz
Content-Type: text/plain
Organization: 
Message-Id: <1092743463.5759.1403.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Aug 2004 07:51:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Coding style document is not consistent with
> itself on whether there should be space after
> ","... This makes it standartize on ", " option.

You can read it both ways, right? It's easy.
I can't even see the difference unless I'm
looking for it.

We don't need any more bureaucracy.

do_this(a,b);
do_this(a, b);
do_this (a,b);
do_this (a, b);

I can read them all. I might notice the space in
front of the '(', but I might not. Even putting a
space in front of the ';' isn't unreadable.

People will pass laws until they are choked off,
unable to move without being in violation of some
silly little thing.


