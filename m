Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262415AbUDDOY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Apr 2004 10:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbUDDOY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Apr 2004 10:24:59 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:36489 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262415AbUDDOY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Apr 2004 10:24:58 -0400
Date: Sun, 4 Apr 2004 10:13:39 -0400
From: Ben Collins <bcollins@debian.org>
To: Marcel Lanz <marcel.lanz@ds9.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PANIC] ohci1394 & copy large files
Message-ID: <20040404141339.GW13168@phunnypharm.org>
References: <20040404141600.GB10378@ds9.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040404141600.GB10378@ds9.ch>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 04, 2004 at 04:16:00PM +0200, Marcel Lanz wrote:
> Since 2.6.4 and still in 2.6.5 I get regurarly a Kernel panic if I try
> to backup large files (10-35GB) to an external attached disc (200GB/JFS) via ieee1394/sbp2.
> 
> Has anyone similar problems ?

Known issue, fixed in our repo. I still need to sync with Linus once I
iron one more issue and merge some more patches.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
