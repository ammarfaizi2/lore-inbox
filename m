Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263632AbUELMmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263632AbUELMmn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 08:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265040AbUELMmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 08:42:43 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:45219 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S263632AbUELMmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 08:42:42 -0400
Date: Wed, 12 May 2004 14:38:59 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: John McCutchan <ttb@tentacle.dhs.org>
Cc: Chris Wedgwood <cw@f00f.org>, nautilus-list@gnome.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH] inotify -- a dnotify replacement
Message-ID: <20040512123859.GA13066@wohnheim.fh-wedel.de>
References: <1084152941.22837.21.camel@vertex> <20040510021141.GA10760@taniwha.stupidest.org> <1084227460.28663.8.camel@vertex>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1084227460.28663.8.camel@vertex>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004 18:17:40 -0400, John McCutchan wrote:
> 
> I now use ino_t and dev_t , though in struct inode, i_no is unsigned
> long?

Correct.  That definition should be changed as well, I just didn't
care enough to submit a patch yet.  Anyway, old mistakes never justify
new mistakes.

Jörn

-- 
People will accept your ideas much more readily if you tell them
that Benjamin Franklin said it first.
-- unknown
