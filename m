Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312516AbSCYTmK>; Mon, 25 Mar 2002 14:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312517AbSCYTmA>; Mon, 25 Mar 2002 14:42:00 -0500
Received: from NEVYN.RES.CMU.EDU ([128.2.145.6]:31393 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id <S312516AbSCYTlq>;
	Mon, 25 Mar 2002 14:41:46 -0500
Date: Mon, 25 Mar 2002 14:40:24 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Brian S Queen <bqueen@nas.nasa.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dnotify header question
Message-ID: <20020325144024.A16694@nevyn.them.org>
Mail-Followup-To: Brian S Queen <bqueen@nas.nasa.gov>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200203251817.KAA04773@octane12.nas.nasa.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 10:17:54AM -0800, Brian S Queen wrote:
> I apologize if this is a repeat question.  I didn't see my own question
> come by on the mailing list though.
> 
> I have been wondering how to get the new dnotify parts currently in
> <linux/fcntl.h> into <fcntl.h>.  I have recompiled and entirley rebuilt
> gcc with the --with-headers option in an effort to get it to
> incorporate the new stuff from <linux/fcntl.h>.  Is this an false
> expectation?  Do I have to submit the changes to the glibc folks to get
> them into the <fcntl.h>?

Yes, you do.

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
