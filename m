Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267934AbTBYLrX>; Tue, 25 Feb 2003 06:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267935AbTBYLrX>; Tue, 25 Feb 2003 06:47:23 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:7944 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S267934AbTBYLrW>; Tue, 25 Feb 2003 06:47:22 -0500
Date: Tue, 25 Feb 2003 11:57:31 +0000
From: John Levon <levon@movementarian.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Andrew Morton <akpm@digeo.com>, wli@holomorphy.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, gh@us.ibm.com
Subject: Re: Horrible L2 cache effects from kernel compile
Message-ID: <20030225115731.GA90975@compsoc.man.ac.uk>
References: <3E5ABBC1.8050203@us.ibm.com> <20030225005922.GU10411@holomorphy.com> <20030225031516.GC49589@compsoc.man.ac.uk> <20030224193504.2ed65230.akpm@digeo.com> <12300000.1046146404@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12300000.1046146404@[10.10.2.4]>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18ndiG-000D5J-00*Knd5O0xFju2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2003 at 08:13:25PM -0800, Martin J. Bligh wrote:

> John, how about a "-r" flag or something to sort the output biggest first?

[moz@lambent src]$ oprofpp --help | grep -- reverse
  -r, --reverse                                 reverse sort order
[moz@lambent src]$ op_time --help | grep -- reverse
  -r, --reverse                                  reverse sort order

Requests like this are my favourite ;)

john
