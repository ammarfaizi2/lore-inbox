Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262592AbVE0U51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262592AbVE0U51 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 16:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVE0U51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 16:57:27 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:1430 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262587AbVE0U5V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 16:57:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, perex@suse.cz, linux-kernel@vger.kernel.org,
       git@vger.kernel.org
Subject: Re: ALSA official git repository
References: <Pine.LNX.4.58.0505271741490.1757@pnote.perex-int.cz>
	<Pine.LNX.4.58.0505270903230.17402@ppc970.osdl.org>
	<Pine.LNX.4.58.0505271941250.1757@pnote.perex-int.cz>
	<Pine.LNX.4.58.0505271113410.17402@ppc970.osdl.org>
	<20050527135124.0d98c33e.akpm@osdl.org>
From: Junio C Hamano <junkio@cox.net>
Date: Fri, 27 May 2005 13:57:18 -0700
In-Reply-To: <20050527135124.0d98c33e.akpm@osdl.org> (Andrew Morton's
 message of "Fri, 27 May 2005 13:51:24 -0700")
Message-ID: <7vekbswfo1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AM" == Andrew Morton <akpm@osdl.org> writes:

AM> I guess the bug here is the use of From: to identify the primary author,
AM> because transporting the patch via email adds ambiguity.

AM> Maybe we should introduce "^Author:"?

While we are at it, we probably would want "^Author-Date:" as
well.

