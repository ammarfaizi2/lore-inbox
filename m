Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268085AbUJSIv7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268085AbUJSIv7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 04:51:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268080AbUJSIv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 04:51:59 -0400
Received: from bristol.swissdisk.com ([65.207.35.130]:48285 "EHLO
	bristol.swissdisk.com") by vger.kernel.org with ESMTP
	id S268070AbUJSIv4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 04:51:56 -0400
Date: Tue, 19 Oct 2004 03:42:12 -0400
From: Ben Collins <bcollins@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, willy@debian.org,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: [BK PATCH] SCSI updates for 2.6.9
Message-ID: <20041019074212.GB19186@phunnypharm.org>
References: <1098137016.2011.339.camel@mulgrave> <200410182341.13648.dtor_core@ameritech.net> <200410190012.28071.dtor_core@ameritech.net> <Pine.LNX.4.58.0410190009260.2287@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410190009260.2287@ppc970.osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2004 at 12:13:08AM -0700, Linus Torvalds wrote:
> 
> Ben,
>  does this look ok to you?
> 
> Arguably the SCSI layer should also have proper prefixes for its constants
> - and in fact they do kind of exist as the GPCMD_xxx constants.  Oh, well.
> Regardless, the sbp2 constants do look like they want prefixing..

Looks good to me.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
