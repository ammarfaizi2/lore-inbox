Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264002AbUD2Jr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264002AbUD2Jr0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 05:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264028AbUD2Jr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 05:47:26 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:47308 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264002AbUD2JrY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 05:47:24 -0400
Date: Thu, 29 Apr 2004 11:46:45 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Timothy Miller <miller@techsource.com>
Cc: Pavel Machek <pavel@ucw.cz>, "Theodore Ts'o" <tytso@mit.edu>,
       Miquel van Smoorenburg <miquels@cistron.nl>,
       linux-kernel@vger.kernel.org
Subject: Re: File system compression, not at the block layer
Message-ID: <20040429094644.GA6098@wohnheim.fh-wedel.de>
References: <408951CE.3080908@techsource.com> <c6bjrd_pms_1@news.cistron.nl> <20040423174146.GB5977@thunk.org> <20040427203426.GB6116@openzaurus.ucw.cz> <409036C4.7030102@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <409036C4.7030102@techsource.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 April 2004 18:57:08 -0400, Timothy Miller wrote:
> 
> I've always felt that way, but every time I mention it, people tell me 
> it's not worth the CPU overhead.  For many years, I have felt that there 
> should be an IP socket type which was inherently compressed.

Ever heard of ssh? ;)

Depending on speed of network and cpus involved, scp can be faster
than nfs.

Jörn

-- 
And spam is a useful source of entropy for /dev/random too!
-- Jasmine Strong
