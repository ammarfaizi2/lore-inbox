Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTKGWCY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Nov 2003 17:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTKGV74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Nov 2003 16:59:56 -0500
Received: from rdns.74.161.62.64.fre.communitycolo.net ([64.62.161.74]:45453
	"EHLO thefinalbean.com") by vger.kernel.org with ESMTP
	id S264620AbTKGUHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Nov 2003 15:07:23 -0500
Message-ID: <35438.128.107.165.13.1068235628.squirrel@mail.yumbrad.com>
Date: Fri, 7 Nov 2003 12:07:08 -0800 (PST)
Subject: CRAMFS
From: "Bradley Bozarth" <prettygood@cs.stanford.edu>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Quinlan originally maintained this, now it is orphaned.  His endian
patch, which implemented the correct behavior according to the docs (which
basically listed always do little endian as a todo), was dropped.

We have been maintaining this patch on our kernel, but it really should go
in - I don't want to spend a ton of time like I did last time to have it
dropped again, however - is anyone thinking of maintaining cramfs?  What
are the chances of the endian fix going in if I submit it again?  (if even
the former maintainer had no success).  I would maintain cramfs if desired
- it hasn't really changed in a long time except in regards to higher
level fs changes.

Thanks,
Brad
