Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWAaWb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWAaWb3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:31:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbWAaWb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:31:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:4566 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751695AbWAaWb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:31:28 -0500
Date: Tue, 31 Jan 2006 17:31:15 -0500
From: Dave Jones <davej@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: mail@renninger.de, mm-commits@vger.kernel.org
Subject: Re: + cpufreq-_ppc-frequency-change-issues-freq-already-lowered-by-bios.patch added to -mm tree
Message-ID: <20060131223115.GF29937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	linux-kernel@vger.kernel.org, mail@renninger.de,
	mm-commits@vger.kernel.org
References: <200601312112.k0VLCRdV031988@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601312112.k0VLCRdV031988@shell0.pdx.osdl.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2006 at 01:14:32PM -0800, Andrew Morton wrote:
 > 
 > The patch titled
 > 
 >      cpufreq: _PPC frequency change issues - freq already lowered by BIOS
 > 
 > has been added to the -mm tree.  Its filename is
 > 
 >      cpufreq-_ppc-frequency-change-issues-freq-already-lowered-by-bios.patch
 > 
 > See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
 > out what to do about this
 > 

*puzzled look*

I merged this into cpufreq-git last week.

diff-tree 0961dd0... (from c70ca00...)
Author: Thomas Renninger <trenn@suse.de>
Date:   Thu Jan 26 18:46:33 2006 +0100

    [CPUFREQ] _PPC frequency change issues



Did your pull fail for some reason? 

		Dave
