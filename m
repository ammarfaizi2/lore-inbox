Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261223AbVCHED4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261223AbVCHED4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 23:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVCHEDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 23:03:55 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:13496 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261223AbVCHEDs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 23:03:48 -0500
Date: Mon, 7 Mar 2005 20:03:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Darren Williams <dsw@gelato.unsw.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Page fault scalability patch V18: Overview
In-Reply-To: <20050307033209.GE19053@cse.unsw.EDU.AU>
Message-ID: <Pine.LNX.4.58.0503072002400.13522@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503011947001.25441@schroedinger.engr.sgi.com>
 <20050304021847.GF28102@cse.unsw.EDU.AU> <20050304024704.GG28102@cse.unsw.EDU.AU>
 <Pine.LNX.4.58.0503040814220.17378@schroedinger.engr.sgi.com>
 <20050306214902.GC19053@cse.unsw.EDU.AU> <Pine.LNX.4.58.0503061557220.3152@schroedinger.engr.sgi.com>
 <20050307033209.GE19053@cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2005, Darren Williams wrote:

> Pid: 362, CPU 0, comm:             kscrubd0
> psr : 0000121008022038 ifs : 8000000000000308 ip  : [<a0000001000cf821>]    Not tainted
> ip is at scrubd_rmpage+0x61/0x140

Would you try the new version on oss.sgi.com please.

