Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263176AbTC1WXt>; Fri, 28 Mar 2003 17:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263177AbTC1WXt>; Fri, 28 Mar 2003 17:23:49 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:7085 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S263176AbTC1WXs>; Fri, 28 Mar 2003 17:23:48 -0500
Date: Fri, 28 Mar 2003 22:34:46 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Joel Becker <Joel.Becker@oracle.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: NICs trading places ?
Message-ID: <20030328223446.GA26102@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Joel Becker <Joel.Becker@oracle.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030328221037.GB25846@suse.de> <20030328222524.GK32000@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030328222524.GK32000@ca-server1.us.oracle.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 28, 2003 at 02:25:25PM -0800, Joel Becker wrote:
 > 	Is this a Red Hat system?  I encountered the same thing on a
 > RHAS system.

I've seen the same issue on a SuSE box, and a Debian box.
 
 > Basically, Anaconda had controlled the module load order
 > in /etc/modules.conf for 2.4.  Because my network drivers were built in
 > in 2.5, they loaded in the order of the compile-in.  This turned out to
 > be the reverse order.

NICs built into kernel in both 2.4 and 2.5.

		Dave

