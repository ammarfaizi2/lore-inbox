Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292738AbSBUTfB>; Thu, 21 Feb 2002 14:35:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292737AbSBUTew>; Thu, 21 Feb 2002 14:34:52 -0500
Received: from coruscant.franken.de ([193.174.159.226]:46285 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S292738AbSBUTel>; Thu, 21 Feb 2002 14:34:41 -0500
Date: Thu, 21 Feb 2002 20:29:04 +0100
From: Harald Welte <laforge@gnumonks.org>
To: "Andreas Herrmann" <AHERRMAN@de.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: netfilter ipv6
Message-ID: <20020221202904.F23307@sunbeam.de.gnumonks.org>
In-Reply-To: <OF56179CF1.BE50D71D-ONC1256B67.004B342F@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <OF56179CF1.BE50D71D-ONC1256B67.004B342F@de.ibm.com>; from AHERRMAN@de.ibm.com on Thu, Feb 21, 2002 at 04:26:41PM +0100
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.17
X-Date: Today is Setting Orange, the 50th day of Chaos in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 04:26:41PM +0100, Andreas Herrmann wrote:
> Hi,
> 
> enclosed is a patch (against version 2.4.17
> of the kernel) for netfilter module ip6_tables.

[..]

Thanks for the bugfix, this is indeed a bug caused by a typo in the original
ip6_tables code.  

I (a linux kernel firewalling maintainer) will forward your bugfix for
inclusion to the stock kernel.

BTW: In case you don't know, the netfilter project has a scoreboard for
contributions.  Your Score will be added to http://www.netfilter.org/scoreboard/

> Regards,
> Andreas

-- 
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
============================================================================
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+ 
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)
