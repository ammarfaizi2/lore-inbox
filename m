Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267583AbTAXHrE>; Fri, 24 Jan 2003 02:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267594AbTAXHrE>; Fri, 24 Jan 2003 02:47:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:139 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267583AbTAXHrD>;
	Fri, 24 Jan 2003 02:47:03 -0500
Date: Fri, 24 Jan 2003 08:55:59 +0100
From: Jens Axboe <axboe@suse.de>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, cdwrite@other.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030124075559.GG910@suse.de>
References: <200301231752.h0NHqOM5001079@burner.fokus.gmd.de> <20030123180124.GB9141@ulima.unil.ch> <20030123180653.GU910@suse.de> <20030123181002.GV910@suse.de> <20030123185554.GC9141@ulima.unil.ch> <20030123190711.GW910@suse.de> <20030123192140.GD9141@ulima.unil.ch> <20030123211805.GY910@suse.de> <20030123215441.GA12179@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123215441.GA12179@ulima.unil.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23 2003, Gregoire Favre wrote:
> On Thu, Jan 23, 2003 at 10:18:05PM +0100, Jens Axboe wrote:
> 
> > No it's my mistake, should be blk_pc_request(). Sorry about that.
> 
> Hello again ;-)
> 
> I don't have more sucess now:

You're not supposed too, but you are supposed to send me the dmesg
output after trying a burn! The patch changes nothing, it just dumps
some info that I need to the logs.

-- 
Jens Axboe

