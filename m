Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbTKKMXM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 07:23:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263489AbTKKMXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 07:23:12 -0500
Received: from apegate.roma1.infn.it ([141.108.7.31]:40461 "EHLO apona.ape")
	by vger.kernel.org with ESMTP id S263475AbTKKMXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 07:23:11 -0500
Date: Tue, 11 Nov 2003 13:23:09 +0100 (CET)
From: "davide.rossetti" <rossetti@roma1.infn.it>
Reply-To: davide.rossetti@roma1.infn.it
To: Andreas Schwab <schwab@suse.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
In-Reply-To: <je65hrrtt1.fsf@sykes.suse.de>
Message-ID: <Pine.LNX.4.44.0311111319290.810-100000@ronin.ape>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003, Andreas Schwab wrote:

> "davide.rossetti" <rossetti@roma1.infn.it> writes:
> 
> > Maybe I was misunderstood... I'm asking why the libc/iso/ansi/posix 
> > engineer did not add the spec a user-mode API to do copy file to file ???
> 
> Because there was no prior art.

:) but late revisions of specs are really recent!!! 

folks are talking about implementing all sort of stuff (web servers,
parallel filesystems, ...)  (partly) in kernel mode and no one cares of
(maybe accelerated) fs copies ???

-- 
______/ Rossetti Davide   INFN - Roma I - APE group \______________
 pho +390649914507/412   web: http://apegate.roma1.infn.it/~rossetti
 fax +390649914423     email: davide.rossetti@roma1.infn.it        

