Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263302AbRFAB2Q>; Thu, 31 May 2001 21:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263307AbRFAB2F>; Thu, 31 May 2001 21:28:05 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:45740 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S263302AbRFAB1z>;
	Thu, 31 May 2001 21:27:55 -0400
Date: Fri, 1 Jun 2001 03:27:36 +0200
From: David Weinehall <tao@acc.umu.se>
To: Tim Hockin <thockin@sun.com>
Cc: pci-ids@ucw.cz, linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [PATCH] new PCI ids
Message-ID: <20010601032735.A12402@khan.acc.umu.se>
In-Reply-To: <3B16ED12.F4BDDFF8@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <3B16ED12.F4BDDFF8@sun.com>; from thockin@sun.com on Thu, May 31, 2001 at 06:17:06PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2001 at 06:17:06PM -0700, Tim Hockin wrote:
> Attached is a patch for cleaning up some PCI ids and adding a few that were
> missing.  Please let me know of any problems with this.
> 
> (diff against 2.4.5)
> 
> Tim
> 
> -- 
> Tim Hockin
> Systems Software Engineer
> Sun Microsystems, Cobalt Server Appliances
> thockin@sun.com
> diff -ruN dist-2.4.5/drivers/pci/pci.ids cobalt-2.4.5/drivers/pci/pci.ids
> --- dist-2.4.5/drivers/pci/pci.ids	Sat May 19 17:49:14 2001
> +++ cobalt-2.4.5/drivers/pci/pci.ids	Thu May 31 14:32:33 2001
> @@ -4,7 +4,7 @@
>  #	Maintained by Martin Mares <pci-ids@ucw.cz>
>  #	If you have any new entries, send them to the maintainer.
>  #
> -#	$Id: pci.ids,v 1.62 2000/06/28 10:56:36 mj Exp $
> +#	$Id: pci.ids,v 1.3 2001/04/04 20:40:25 thockin Exp $

Shouldn't that be 1.63?!


/David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
