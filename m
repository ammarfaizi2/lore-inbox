Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266415AbUFQI3s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266415AbUFQI3s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 04:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266414AbUFQI3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 04:29:47 -0400
Received: from tor.morecom.no ([64.28.24.90]:11402 "EHLO tor.morecom.no")
	by vger.kernel.org with ESMTP id S266415AbUFQI3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 04:29:44 -0400
Subject: Re: mode data=journal in ext3. Is it safe to use?
From: Petter Larsen <pla@morecom.no>
To: Timothy Miller <miller@techsource.com>
Cc: ext3 <ext3-users@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <40D06C0B.7020005@techsource.com>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan>
	 <1087322976.1874.36.camel@pla.lokal.lan>  <40D06C0B.7020005@techsource.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1087460983.2765.34.camel@pla.lokal.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 17 Jun 2004 10:29:43 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Data integrity is much more important for us than speed.
> > 
> 
> 
> You might want to consider ReiserFS or one of the others which were 
> designed with journaling in mind.  And I hope you're using RAID1 or RAID5.

We are using ext3 on a compact flash disk in an embedded device. So we
are not using RAID systems.

Best regards
-- 
Petter Larsen
cand. scient.
moreCom as
913 17 222
