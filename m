Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265595AbUBBOzj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 09:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265657AbUBBOzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 09:55:39 -0500
Received: from mail46-s.fg.online.no ([148.122.161.46]:18146 "EHLO
	mail46-s.fg.online.no") by vger.kernel.org with ESMTP
	id S265595AbUBBOzi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 09:55:38 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: real-time filesystem monitoring
References: <Pine.NEB.4.58.0402021412150.12346@mx.freeshell.org>
From: Esben Stien <executiv@online.no>
Date: 02 Feb 2004 15:52:12 +0100
In-Reply-To: <Pine.NEB.4.58.0402021412150.12346@mx.freeshell.org>
Message-ID: <87y8rlttyb.fsf@online.no>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ognen Duzlevski <maketo@sdf.lonestar.org> writes:

> I am working on a GPL-ed tool to monitor a filesystem in real time and
> then perform a backup as soon as something has changed. 

Yeah, been waiting a long time for this

> I tried FAM/libfam and dnotify and both choked on large directory
> hierarchies. 

Yeah, I first checked this out too. 

> Anything similar on
> Linux?

Filemon, http://www.sysinternals.com, runs on both gnu and windows but
is not free software. 

-- 
b0ef

