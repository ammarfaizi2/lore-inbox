Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265073AbTGCRXC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 13:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265074AbTGCRXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 13:23:02 -0400
Received: from va-leesburg1b-227.chvlva.adelphia.net ([68.64.41.227]:53128
	"EHLO ccs.covici.com") by vger.kernel.org with ESMTP
	id S265073AbTGCRXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 13:23:00 -0400
To: linux-kernel@vger.kernel.org
Subject: local nntp connections much slower in 2.5.73 than in 2.4.x
From: John Covici <covici@ccs.covici.com>
Date: Thu, 03 Jul 2003 13:37:26 -0400
Message-ID: <m3znjvbjft.fsf@ccs.covici.com>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  I have been noticing an nntp problem in my 2.5.73 kernel.  I
have inn 2.3 set up on my machine and I use gnus to read mail and
news.  Now what happens is that when gnus starts up it connects to
the server (same box) and gets all the active newsgroups.  What I
have noticed is a drastic slowdown in 2.5.73 (or other 7x) than in my
2.4.20 kernel and I was wondering if anyone else has seen this or can
tell me either a workaround or what is going on with this.

Thanks.

-- 
         John Covici
         covici@ccs.covici.com
