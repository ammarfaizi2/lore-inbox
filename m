Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261814AbSJIOix>; Wed, 9 Oct 2002 10:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261815AbSJIOix>; Wed, 9 Oct 2002 10:38:53 -0400
Received: from blowme.phunnypharm.org ([65.207.35.140]:34067 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261814AbSJIOiv>; Wed, 9 Oct 2002 10:38:51 -0400
Date: Wed, 9 Oct 2002 10:44:14 -0400
From: Ben Collins <bcollins@debian.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: BK kernel commits list
Message-ID: <20021009144414.GZ26771@phunnypharm.org>
References: <20021009.045845.87764065.davem@redhat.com> <18079.1034115320@passion.cambridge.redhat.com> <20021008.175153.20269215.davem@redhat.com> <200210091149.g99BnWQ5000628@pool-141-150-241-241.delv.east.verizon.net> <7908.1034165878@passion.cambridge.redhat.com> <3DA4392B.8070204@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA4392B.8070204@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 09, 2002 at 10:11:55AM -0400, Jeff Garzik wrote:
> A couple of suggestions for the output...
> 
> The BitKeeper header is unfortunately less than useful at times -- often 
> multiple cset descriptions wind up in the header -- so I would suggest 
> exporting the patch with "-hdu" instead of "-du", and then manually 
> adding the changeset info and description at the top.
> 
> Also, diffstat output prepended would be nice too.

Just please make sure that the changeset info where it describes all the
files in the delta. I.e. the ones that are moved, deleted, new. There's
no way to deduce moves from the patch.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
