Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264005AbTDWLqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 07:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264006AbTDWLqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 07:46:13 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:59829 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264005AbTDWLqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 07:46:12 -0400
Date: Wed, 23 Apr 2003 13:58:09 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Can one build 2.5.68 with allyesconfig?
Message-ID: <20030423115809.GA14483@wohnheim.fh-wedel.de>
References: <3EA5AABF.4090303@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3EA5AABF.4090303@techsource.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 April 2003 16:49:03 -0400, Timothy Miller wrote:
> 
> Is anyone else able to build 2.5.68 with allyesconfig?

No, of course not. But I can give you a .config that comes very close
on i386. Resulting vmlinux is 28MB, so this shouldn't boot.

It was created for 2.5.67 with allyesconfig and manual weedout, then
updated to 2.5.68.

Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.
