Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263314AbTDCHcw>; Thu, 3 Apr 2003 02:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263315AbTDCHcw>; Thu, 3 Apr 2003 02:32:52 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:20700 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S263314AbTDCHcv>; Thu, 3 Apr 2003 02:32:51 -0500
Date: Thu, 3 Apr 2003 09:44:12 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Christoph Rohland <cr@sap.com>, CaT <cat@zip.com.au>, tomlins@cam.org,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: allow percentile size of tmpfs (2.5.66 / 2.4.20-pre2)
Message-ID: <20030403074412.GB19536@wohnheim.fh-wedel.de>
References: <20030402204450.GB17890@wohnheim.fh-wedel.de> <Pine.LNX.4.44.0304022201010.3034-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0304022201010.3034-100000@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 April 2003 22:04:10 +0100, Hugh Dickins wrote:
> On Wed, 2 Apr 2003, Jörn Engel wrote:
> > 
> > Can you show me the easy part with this setup?
> > 256MB RAM
> > 512MB swap
> > 50% tmpfs (384MB)
> > fill tmpfs completely
> > swapoff -a
> 
> Don't blame Christoph for that, one of these days I'll face up to
> my responsibilities and make swapoff fail (probably get itself
> OOM-killed) instead of having everything else OOM-killed.

Ack. If you do that, I'd have to agree with Christoph.

Jörn

-- 
Homo Sapiens is a goal, not a description.
-- unknown
