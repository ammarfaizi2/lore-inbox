Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbTBJLj7>; Mon, 10 Feb 2003 06:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbTBJLj7>; Mon, 10 Feb 2003 06:39:59 -0500
Received: from poup.poupinou.org ([195.101.94.96]:47642 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP
	id <S264853AbTBJLj6>; Mon, 10 Feb 2003 06:39:58 -0500
Date: Mon, 10 Feb 2003 12:49:39 +0100
To: MATTHEW ADAM GERGINSKI <mag357@psu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: problems after ext3 recovery
Message-ID: <20030210114939.GA25632@poup.poupinou.org>
References: <200302090810.DAA10550@webmail11.cac.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302090810.DAA10550@webmail11.cac.psu.edu>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2003 at 03:10:38AM -0500, MATTHEW ADAM GERGINSKI wrote:
>  Wondering if this is a kernel-related problem... upon boot, the filesystem is
> mounted as readonly, and it says that read-write will be enabled during the
> recovery process.  The recovery complete's successfully, but then it does not
> remount as read-write, it mounts as readonly, as shown byt he output here:

It is expected.  Fix your rc scripts.

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
