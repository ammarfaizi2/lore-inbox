Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTJZObb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 09:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263174AbTJZOba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 09:31:30 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:39146 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S263173AbTJZOba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 09:31:30 -0500
Date: Sun, 26 Oct 2003 09:18:37 -0500
From: Ben Collins <bcollins@debian.org>
To: Matthew J Galgoci <mgalgoci@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: sbp2 slab corruiton in 2.6-test9
Message-ID: <20031026141837.GA7904@phunnypharm.org>
References: <Pine.LNX.4.44.0310261357100.16378-100000@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310261357100.16378-100000@parcelfarce.linux.theplanet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 26, 2003 at 02:01:26PM +0000, Matthew J Galgoci wrote:
> Hi Folks,
> 
> I'm seeing slab corruption in 2.6-test9 when I do a 
> cat /proc/scsi/scsi
> 

Known. The fix is non-trivial, so I am holding off on it until 2.6.0
gets out.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
