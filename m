Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUD2Ohn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUD2Ohn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 10:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264561AbUD2Ohn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 10:37:43 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:36752 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S264668AbUD2OgT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 10:36:19 -0400
Date: Thu, 29 Apr 2004 16:36:18 +0200
From: bert hubert <ahu@ds9a.nl>
To: Shobhit Mathur <shobhitmmathur@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Latest /proc implementation ?.....
Message-ID: <20040429143618.GA8603@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Shobhit Mathur <shobhitmmathur@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20040429133545.35335.qmail@web90001.mail.scd.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040429133545.35335.qmail@web90001.mail.scd.yahoo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 06:35:45AM -0700, Shobhit Mathur wrote:


> I am aware of existing /proc/ implementations wherein
> buffer-size is limited and data upto 4096 bytes
> only is displayable via the "proc_info" entry-point in
> the Scsi_Host_Template structure.

I think you mean seq_file, described in http://lwn.net/Articles/22355/

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
