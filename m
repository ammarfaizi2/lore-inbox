Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTCBWzE>; Sun, 2 Mar 2003 17:55:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261934AbTCBWzE>; Sun, 2 Mar 2003 17:55:04 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:58035 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S261908AbTCBWzD>; Sun, 2 Mar 2003 17:55:03 -0500
Date: Sun, 2 Mar 2003 23:05:04 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: John Levon <levon@movementarian.org>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@digeo.com>,
       linux-kernel@vger.kernel.org, cliffw@osdl.org, akpm@zip.com.au,
       slpratt@austin.ibm.com, haveblue@us.ibm.com
Subject: Re: [PATCH] documentation for basic guide to profiling
Message-ID: <20030302230503.GA15004@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	John Levon <levon@movementarian.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Anton Blanchard <anton@samba.org>, Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	cliffw@osdl.org, akpm@zip.com.au, slpratt@austin.ibm.com,
	haveblue@us.ibm.com
References: <8550000.1046419962@[10.10.2.4]> <20030228002935.256ffa98.akpm@digeo.com> <20030228112238.GJ4911@codemonkey.org.uk> <20030228152838.GB32449@gtf.org> <20010101052723.GB22212@krispykreme> <447430000.1046473881@flay> <20030301175114.GA30911@codemonkey.org.uk> <20030301204857.GA24330@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030301204857.GA24330@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 08:48:57PM +0000, John Levon wrote:

 > >  > +stop		opcontrol --stop
 > > --stop unsupported. use "--shutdown"
 > 
 > Stop running 2.4 ! :)
 > 
 > --stop works on 2.5 only ...

That seems quite confusing. Why not make --stop an
alias for --shutdown if running on 2.4 ?

        Dave

