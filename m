Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266526AbUBSHpm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 02:45:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266395AbUBSHpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 02:45:42 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41349 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266526AbUBSHpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 02:45:40 -0500
Date: Thu, 19 Feb 2004 08:26:30 +0100
From: Pavel Machek <pavel@suse.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: Andrea Arcangeli <andrea@suse.de>,
       Nigel Cunningham <ncunningham@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Reserved page flaging of 2.4 kernel memory changed recently?
Message-ID: <20040219072629.GB467@openzaurus.ucw.cz>
References: <200402050941.34155.mhf@linuxmail.org> <20040208020624.GG31926@dualathlon.random> <200402100625.41288.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402100625.41288.mhf@linuxmail.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I actually would like to rename the bit PG_nosave to PG_donttouch ;)

Its used for swsusp internal data, too...
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

