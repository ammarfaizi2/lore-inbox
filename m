Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbUF0ORW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbUF0ORW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 10:17:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262756AbUF0ORW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 10:17:22 -0400
Received: from tor.morecom.no ([64.28.24.90]:54445 "EHLO tor.morecom.no")
	by vger.kernel.org with ESMTP id S262744AbUF0ORU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 10:17:20 -0400
Subject: Re: mode data=journal in ext3. Is it safe to use?
From: Petter Larsen <pla@morecom.no>
To: Daniel Pittman <daniel@rimspace.net>
Cc: ext3 <ext3-users@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <87wu26mto2.fsf@enki.rimspace.net>
References: <40FB8221D224C44393B0549DDB7A5CE83E31B1@tor.lokal.lan>
	 <1087322976.1874.36.camel@pla.lokal.lan> <40D06C0B.7020005@techsource.com>
	 <1087460983.2765.34.camel@pla.lokal.lan> <87wu26mto2.fsf@enki.rimspace.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1088345837.5288.1.camel@pla.lokal.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Sun, 27 Jun 2004 16:17:17 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > We are using ext3 on a compact flash disk in an embedded device. So we
> > are not using RAID systems.
> 
> Watch out - even with the internal wear leveling the CF disk will do,
> ext3 is still a pretty heavy filesystem to use there.
> 
>      Daniel

Well, which filesystem would you then used for read-write on this CF?


-- 
Petter Larsen
cand. scient.
moreCom as
913 17 222
