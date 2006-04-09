Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWDIU7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWDIU7O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 16:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750813AbWDIU7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 16:59:14 -0400
Received: from moci.net4u.de ([217.7.64.195]:47018 "EHLO moci.net4u.de")
	by vger.kernel.org with ESMTP id S1750809AbWDIU7O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 16:59:14 -0400
Message-ID: <44397596.5020809@net4u.de>
Date: Sun, 09 Apr 2006 22:59:02 +0200
From: leonie herzberg <leo@net4u.de>
User-Agent: Thunderbird 1.5 (X11/20060113)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: alpha DEAD on >=2.6.16-rc3
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I already posted a bugreport on the bugzilla
(http://bugzilla.kernel.org/show_bug.cgi?id=6351) but I feel no one is
recognizing that; and as I see it, it's a rather hard bug since it
throws a kernel panic immediately at boot time. I believe it has to do
with the change made in 2.6.16-rc3 concerning "cpu_possible_map". None
of the newer kernel versions works.
As you can see at the first (and up to now, only) comment, this is not
only my problem.
Maybe it appears only in connection with SMP. I can't tell.


Leonie
