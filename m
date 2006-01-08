Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030629AbWAHNi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030629AbWAHNi0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 08:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbWAHNi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 08:38:26 -0500
Received: from herkules.vianova.fi ([194.100.28.129]:27591 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S932731AbWAHNi0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 08:38:26 -0500
Date: Sun, 8 Jan 2006 15:38:22 +0200
From: Ville Herva <vherva@vianova.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: oops pauser.
Message-ID: <20060108133822.GD31624@vianova.fi>
Reply-To: vherva@vianova.fi
References: <20060105045212.GA15789@redhat.com> <Pine.LNX.4.61.0601050907510.10161@yvahk01.tjqt.qr> <20060105103339.GG20809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060105103339.GG20809@redhat.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 05:33:39AM -0500, you [Dave Jones] wrote:
> 
> If I had any faith in the sturdyness of the floppy driver, I'd
> recommend someone looked into a 'dump oops to floppy' patch, but
> it too relies on a large part of the system being in a sane
> enough state to write blocks out to disk.

I believe kmsgdump (http://www.xenotime.net/linux/kmsgdump/) uses its own
minimal 16-bit floppy driver to save the oops dump. 

Kmsgdump has been around for ages and still works with 2.6.x. I almost
always use it (all of my boxes still have floppy drives.)


-- v -- 

v@iki.fi

