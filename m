Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbTGFOtT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 10:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbTGFOtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 10:49:19 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:42467 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S261292AbTGFOtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 10:49:18 -0400
Date: Sun, 6 Jul 2003 09:41:56 -0400
From: Ben Collins <bcollins@debian.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.22-pre3
Message-ID: <20030706134156.GG502@phunnypharm.org>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 05, 2003 at 10:02:09PM -0300, Marcelo Tosatti wrote:
> 
> Hi,
> 
> Here goes -pre3. It contains a lot of updates and fixes all over.

Any chance you could be consistent in tagging the -pre's? Neither pre2,
nor pre3 is tagged in BK, and thus, not tagged in CVS/SVN either.

It just makes it easier when tracking down regressions to have known
points of reference common across BK/CVS/SVN/tar+diff.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
