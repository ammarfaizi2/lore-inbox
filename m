Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263364AbTLJCpB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 21:45:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbTLJCpB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 21:45:01 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:8324 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263364AbTLJCo7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 21:44:59 -0500
Date: Tue, 09 Dec 2003 18:44:38 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jakma <paul@clubi.ie>, Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Joe Thornber <thornber@sistina.com>, linux-kernel@vger.kernel.org
Subject: Re: Device-mapper submission for 2.4
Message-ID: <1258280000.1071024272@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.56.0312092329280.30298@fogarty.jakma.org>
References: <Pine.LNX.4.44.0312092047450.1289-100000@logos.cnet> <Pine.LNX.4.56.0312092329280.30298@fogarty.jakma.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd really like to see one of:
> 
> - backwards compat: 2.6 have LVM1 support
>
> - the DM tools to support both LVM1 and LVMx in 2.6, on a *long-term* 
>   basis

Some form of backward compatibility from 2.6 would seem a much more 
sensible thing to fight for. Foisting forward comaptibility on an 
older release seems like a bad road to go down.
 
M.
