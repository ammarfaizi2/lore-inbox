Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTGTKQe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 06:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265422AbTGTKQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 06:16:34 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:13534 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263861AbTGTKQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 06:16:33 -0400
Date: Sun, 20 Jul 2003 06:30:18 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Markus Plail <linux-kernel@gitteundmarkus.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: how to use "ATAPI:" protocol for IDE CD/RWs??
In-Reply-To: <87d6g51oni.fsf@gitteundmarkus.de>
Message-ID: <Pine.LNX.4.53.0307200629200.17990@localhost.localdomain>
References: <Pine.LNX.4.53.0307200606120.17848@localhost.localdomain>
 <87d6g51oni.fsf@gitteundmarkus.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jul 2003, Markus Plail wrote:

> On Sun, 20 Jul 2003, Robert P. J. Day wrote:
> > are there known problems with trying to access IDE CD/RWs directly
> > through the IDE drivers, rather than using SCSI emulation?  i've tried
> > testing cdrecord using the "dev=ATAPI:x,y,z" option, and am having
> > no luck.
> 
> If you don't have ide-scsi emulation, use dev=dev/hdX
> I never really understood what ATAPI: is for. Presumably you need it
> for PCATA found in notebooks.

this is on a laptop -- dell inspiron 8100.  i guess i should have
mentioned that. :-(

rday
