Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271363AbTHHO2k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 10:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271365AbTHHO2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 10:28:40 -0400
Received: from quechua.inka.de ([193.197.184.2]:9195 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S271363AbTHHO2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 10:28:39 -0400
From: Bernd Eckenfels <ecki-lkm@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 status: benchmarked vs. V3 (and ext3)
In-Reply-To: <1060351312.25209.468.camel@passion.cambridge.redhat.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.19-20030610 ("Darts") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19l8EM-0006R3-00@calista.inka.de>
Date: Fri, 08 Aug 2003 16:28:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1060351312.25209.468.camel@passion.cambridge.redhat.com> you wrote:
> The practice of using JFFS2 on CF (and other real block devices) isn't
> really something I encourage, but it seems to have happened because
> there isn't a 'real' block device based file system which is
> powerfail-save, optimised for space and which uses compression. If
> reiser4 can fill that gap, that would be pleasing to me.

Thanks for that great article, would you care to describe where the slowness
of JFFS2 is coming from?

Do you have experiences with XFS and ext3 (datajournal) filesystems in terms
of power fail security?


Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
