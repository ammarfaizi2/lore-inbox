Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTENQL0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTENQL0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:11:26 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:13778 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262177AbTENQLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:11:25 -0400
Date: Wed, 14 May 2003 18:23:23 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Ahmed Masud <masud@googgun.com>
Cc: Yoav Weiss <ml-lkml@unpatched.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: encrypted swap [was: The disappearing sys_call_table export.]
Message-ID: <20030514162323.GB16093@wohnheim.fh-wedel.de>
References: <20030514155727.GA16093@wohnheim.fh-wedel.de> <Pine.LNX.4.33.0305141211070.12082-100000@marauder.googgun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0305141211070.12082-100000@marauder.googgun.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003 12:13:03 -0400, Ahmed Masud wrote:
> 
> The idea is to have encryption keys for the pages to be unique on a
> per-uid per-process basis. So one user on the system cannot access (even
> if they are root) parts of another's private data.  To achieve this,
> different parts of swap device need to be encrypted with different keys.

How do user *know* that root cannot simply bypass this security?

Root, god, what's the difference? ;-)

Jörn

-- 
"Error protection by error detection and correction."
-- from a university class
