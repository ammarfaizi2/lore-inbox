Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUHaLKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUHaLKW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Aug 2004 07:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267852AbUHaLKW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Aug 2004 07:10:22 -0400
Received: from mk-smarthost-4.mail.uk.tiscali.com ([212.74.114.40]:18957 "EHLO
	mk-smarthost-4.mail.uk.tiscali.com") by vger.kernel.org with ESMTP
	id S267818AbUHaLKT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Aug 2004 07:10:19 -0400
From: David M <eseol@tiscali.co.uk>
To: linux-kernel@vger.kernel.org
Subject: mga drm problem despite recent changes
Date: Tue, 31 Aug 2004 12:25:35 +0100
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408311225.35151.eseol@tiscali.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello 

I believe some bugs have been fixed in the mga drm code that is part of the 
2.6 lowlat P8 patch set.  Most of my audio qt apps now work (eg qjackctl muse 
rosegarden etc) however there still seems to be a problem with mixxx ( a dj 
software).  All is fine using the 2.4 kernel and all is well when not using 
drm in the 2.6.8.1-P8 kernel but when drm is enabled in the 2.6.8.1-p8 kernel 
mixxx freezes and kill, top and ps commands stop working and as a result a 
clean shutdown is impossible.

Sorry its not a detailed report as its only a users perspective.

Dave
