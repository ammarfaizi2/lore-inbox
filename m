Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262946AbTDBUdb>; Wed, 2 Apr 2003 15:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263011AbTDBUdb>; Wed, 2 Apr 2003 15:33:31 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:61356 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262946AbTDBUda>; Wed, 2 Apr 2003 15:33:30 -0500
Date: Wed, 2 Apr 2003 22:44:50 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Christoph Rohland <cr@sap.com>
Cc: CaT <cat@zip.com.au>, Hugh Dickins <hugh@veritas.com>, tomlins@cam.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Message-ID: <20030402204450.GB17890@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.44.0304011734370.1503-100000@localhost.localdomain> <ovd6k5l60d.fsf@sap.com> <20030402144432.GB536@zip.com.au> <ovadf8ls8e.fsf@sap.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ovadf8ls8e.fsf@sap.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 April 2003 19:33:05 +0200, Christoph Rohland wrote:
> 
> No, that's why I said you would need hooks into swapon and
> swapoff. Then it would adjust on the fly. Else it's useless from the
> usability point of view. With these hooks it's easy to do.

Can you show me the easy part with this setup?
256MB RAM
512MB swap
50% tmpfs (384MB)
fill tmpfs completely
swapoff -a

Jörn

-- 
It's just what we asked for, but not what we want!
-- anonymous
