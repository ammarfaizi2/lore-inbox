Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263467AbTDSUmn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Apr 2003 16:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTDSUmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Apr 2003 16:42:42 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:12813 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263467AbTDSUml
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Apr 2003 16:42:41 -0400
Date: Sat, 19 Apr 2003 22:56:21 +0200
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
Message-ID: <20030419205621.GA15577@hh.idb.hist.no>
References: <20030419180421.0f59e75b.skraw@ithnet.com> <87lly6flrz.fsf@deneb.enyo.de> <20030419200712.3c48a791.skraw@ithnet.com> <20030419184120.GH669@gallifrey>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030419184120.GH669@gallifrey>
User-Agent: Mutt/1.5.3i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 19, 2003 at 07:41:20PM +0100, Dr. David Alan Gilbert wrote:
> 	4) It is OK saying return the drive and get a new one - but many of
> 	   us can't do this in a commercial environment where the contents of
> 		 the drive are confidential - leading to stacks of dead drives
> 		 (often many inside their now short warranty periods).

There are commercially available programs that guarantees to
wipe your drive clean - including hidden areas and remapped
sectors.  You should then be able to send drives
back for warranty replacement.

There are also bulk erasers that reset every bit magnetically,
but those will probably void the warranty too.  (You'll
need a low-level reformat to recreate sector addresses on the
suddenly blank surface.)


Helge Hafting  		 

