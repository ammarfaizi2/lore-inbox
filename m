Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSIJBWn>; Mon, 9 Sep 2002 21:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSIJBWn>; Mon, 9 Sep 2002 21:22:43 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:22032 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S316465AbSIJBWm>; Mon, 9 Sep 2002 21:22:42 -0400
Date: Tue, 10 Sep 2002 02:27:20 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.34 - EXPORT_SYMBOL(reparent_to_init) for module build
Message-ID: <20020910012720.GA70929@compsoc.man.ac.uk>
References: <20020909172111.A19949@eng2.beaverton.ibm.com> <20020910002418.GA69537@compsoc.man.ac.uk> <20020909181216.A20508@eng2.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020909181216.A20508@eng2.beaverton.ibm.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Boards of Canada - Geogaddi
X-Scanner: exiscan *17oZoH-0000SQ-00*azjOQ.6swdU* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 06:12:16PM -0700, Patrick Mansfield wrote:

> Perhaps reparent_to_init should now be static?

My grep certainly agrees with this. (Don't forget to remove the
prototype in sched.h too).

regards
john

-- 
"This *is* Usenet, after all, where virtually every conversation that goes on
is fairly ludicrous in the first place."
	- Godwin's Law FAQ
