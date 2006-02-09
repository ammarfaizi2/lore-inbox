Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWBIXVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWBIXVy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 18:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWBIXVy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 18:21:54 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:50391 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750763AbWBIXVy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 18:21:54 -0500
Date: Thu, 9 Feb 2006 15:21:47 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Michael Kerrisk <mtk-manpages@gmx.net>
cc: linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net
Subject: Re: man-pages-2.23 is released
In-Reply-To: <18893.1139526575@www004.gmx.net>
Message-ID: <Pine.LNX.4.62.0602091520500.11317@schroedinger.engr.sgi.com>
References: <16806.1139255986@www031.gmx.net> <18893.1139526575@www004.gmx.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2006, Michael Kerrisk wrote:

> mbind.2

Does this include a description of the new flags MPOL_MF_MOVE and 
MPOL_MF_MOVE_ALL? There is a manpage in Andi Kleen's numactl 0.9.2 that 
describes these.
