Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932416AbWBMShz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWBMShz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 13:37:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWBMShz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 13:37:55 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:61785 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S932416AbWBMShy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 13:37:54 -0500
Date: Mon, 13 Feb 2006 10:33:59 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mauro Tassinari <mtassinari@cmanet.it>, Dave Jones <davej@redhat.com>,
       Meelis Roos <mroos@linux.ee>, dtor_core@ameritech.net,
       linux-input@atrey.karlin.mff.cuni.cz,
       Claudio Martins <ctpm@rnl.ist.utl.pt>, kurt.hackel@oracle.com,
       ocfs2-devel@oss.oracle.com
Subject: Re: 2.6.16-rc3: more regressions
Message-ID: <20060213183359.GA20175@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <Pine.LNX.4.64.0602121709240.3691@g5.osdl.org> <20060213170945.GB6137@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060213170945.GB6137@stusta.de>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2006 at 06:09:45PM +0100, Adrian Bunk wrote:
> Subject    : OCFS2 Filesystem inconsistency across nodes
> References : http://lkml.org/lkml/2006/2/10/14
> Submitter  : Claudio Martins <ctpm@rnl.ist.utl.pt>
> Handled-By : Mark Fasheh <mark.fasheh@oracle.com>
> Status     : unknown
Definitely a regression. I think some patch that was merged shortly after
OCFS2 is causing this. I'm trying to narrow it down to a single patch right
now...
	--Mark 

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

