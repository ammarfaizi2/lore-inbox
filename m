Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271732AbRHQWCE>; Fri, 17 Aug 2001 18:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271730AbRHQWBz>; Fri, 17 Aug 2001 18:01:55 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:1039 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S271725AbRHQWBk>; Fri, 17 Aug 2001 18:01:40 -0400
Date: Fri, 17 Aug 2001 17:57:39 -0400
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Milind <dmilind@india.hp.com>
Cc: linux-kernel@vger.kernel.org, blore-linux@yahoogroups.com
Subject: Re: Info about /dev/kmem required
Message-ID: <20010817175739.I19385@arthur.ubicom.tudelft.nl>
In-Reply-To: <3B7D232B.FEA189AD@india.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B7D232B.FEA189AD@india.hp.com>; from dmilind@india.hp.com on Fri, Aug 17, 2001 at 07:29:08PM +0530
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2001 at 07:29:08PM +0530, Milind wrote:
> I wanted some info about ' /dev/kmem ' file with respect to following
> 
> 1)  What this file contains?

>From Documentation/devices.txt:

  1 char        Memory devices
                  1 = /dev/mem          Physical memory access
                  2 = /dev/kmem         Kernel virtual memory access

> 2)  Who  writes into this file?

Normally nobody does, though it can be used to patch up a running
system (in theory).

> Reply at the earliest.

I'm sorry, we're not a helpdesk.


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
