Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269019AbTCAUik>; Sat, 1 Mar 2003 15:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269020AbTCAUik>; Sat, 1 Mar 2003 15:38:40 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:44295 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S269019AbTCAUik>; Sat, 1 Mar 2003 15:38:40 -0500
Date: Sat, 1 Mar 2003 20:48:57 +0000
From: John Levon <levon@movementarian.org>
To: Dave Jones <davej@codemonkey.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Anton Blanchard <anton@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       cliffw@osdl.org, akpm@zip.com.au, slpratt@austin.ibm.com,
       haveblue@us.ibm.com
Subject: Re: [PATCH] documentation for basic guide to profiling
Message-ID: <20030301204857.GA24330@compsoc.man.ac.uk>
References: <8550000.1046419962@[10.10.2.4]> <20030228002935.256ffa98.akpm@digeo.com> <20030228112238.GJ4911@codemonkey.org.uk> <20030228152838.GB32449@gtf.org> <20010101052723.GB22212@krispykreme> <447430000.1046473881@flay> <20030301175114.GA30911@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030301175114.GA30911@codemonkey.org.uk>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18pDuj-000HXP-00*S5Z0iXD5uBI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 05:51:14PM +0000, Dave Jones wrote:

>  > +start daemon	opcontrol --start-daemon
> 
> --start implies starting the daemon if it isn't started
> already.
> 
>  > +stop		opcontrol --stop
> 
> --stop unsupported. use "--shutdown"

Stop running 2.4 ! :)

--stop works on 2.5 only ...

regards
john
