Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261502AbTCTPMC>; Thu, 20 Mar 2003 10:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261510AbTCTPIK>; Thu, 20 Mar 2003 10:08:10 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4817 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261522AbTCTPGz>;
	Thu, 20 Mar 2003 10:06:55 -0500
Date: Thu, 20 Mar 2003 15:17:54 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org, jes@trained-monkey.org
Subject: Re: [PATCH] Fixup warning for acenic
Message-ID: <20030320151754.GB14520@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please don't delete this table.  At some point when Jes gets his head
out of the "must support Linux 1.2" space, this table will be used and
then this driver will support hotplugging.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
