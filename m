Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbUBZNg3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 08:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbUBZNg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 08:36:29 -0500
Received: from bristol.phunnypharm.org ([65.207.35.130]:38605 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S262791AbUBZNfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 08:35:52 -0500
Date: Thu, 26 Feb 2004 08:14:45 -0500
From: Ben Collins <bcollins@debian.org>
To: Brian Jackson <brian@brianandsara.net>
Cc: linux-kernel@vger.kernel.org, kai.engert@gmx.de
Subject: Re: only ieee1394 from 2.4.20 works for me
Message-ID: <20040226131445.GF651@phunnypharm.org>
References: <4038BDC3.9030304@kuix.de> <Pine.LNX.4.58L.0402251153550.21511@logos.cnet> <200402260012.25098.brian@brianandsara.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402260012.25098.brian@brianandsara.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I however don't have the same problems you describe. Newer versions just 
> simply fail to see anything attached to the ieee1394 bus. I'm using a via 
> epia M10000. I saw a report similar to mine on the 1394 list, but it went 
> unanswered.

Did you cat /proc/bus/ieee1394/devices?
Did you try using the rescan-scsi-bus.sh script?


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
