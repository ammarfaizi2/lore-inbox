Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265259AbUANXhQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 18:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266290AbUANXei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 18:34:38 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:54009 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S266293AbUANXas
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 18:30:48 -0500
Date: Wed, 14 Jan 2004 18:30:47 -0500 (EST)
From: Jim Faulkner <jfaulkne@ccs.neu.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: AES cryptoloop corruption under recent -mm kernels
In-Reply-To: <20040114125210.1dc50593.akpm@osdl.org>
Message-ID: <Pine.GSO.4.58.0401141826180.15674@denali.ccs.neu.edu>
References: <Pine.GSO.4.58.0401141357410.10111@denali.ccs.neu.edu>
 <20040114125210.1dc50593.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 14 Jan 2004, Andrew Morton wrote:

>
> It would be interesting to find out if 2.6.0-mm2 is working OK for you.
>

Yep, it does!  I copied several gigs of data to the cryptoloop partition
with no corruption.  Thanks!

Jim Faulkner
