Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266720AbTAWS6W>; Thu, 23 Jan 2003 13:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267121AbTAWS6W>; Thu, 23 Jan 2003 13:58:22 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:51117 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S266720AbTAWS6V>;
	Thu, 23 Jan 2003 13:58:21 -0500
Date: Thu, 23 Jan 2003 20:07:11 +0100
From: Jens Axboe <axboe@suse.de>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: Joerg Schilling <schilling@fokus.fraunhofer.de>, cdwrite@other.debian.org,
       linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030123190711.GW910@suse.de>
References: <200301231752.h0NHqOM5001079@burner.fokus.gmd.de> <20030123180124.GB9141@ulima.unil.ch> <20030123180653.GU910@suse.de> <20030123181002.GV910@suse.de> <20030123185554.GC9141@ulima.unil.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030123185554.GC9141@ulima.unil.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23 2003, Gregoire Favre wrote:
> On Thu, Jan 23, 2003 at 07:10:02PM +0100, Jens Axboe wrote:
> 
> > oh, and dump failed->sense_len as well!
> 
> ??? I am sorry, I undestood the first one, but not this one...
> Could you explain it a little more?

just add a len=%d to the printk line, and failed->sense_len as the
argument.

-- 
Jens Axboe

