Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262290AbSI1Rng>; Sat, 28 Sep 2002 13:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262292AbSI1Rng>; Sat, 28 Sep 2002 13:43:36 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:14341 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S262290AbSI1Rnf>; Sat, 28 Sep 2002 13:43:35 -0400
Date: Sat, 28 Sep 2002 18:48:49 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: floppy still broken in 2.5.39 ?
Message-ID: <20020928174849.GA55414@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *17vLhx-000LTf-00*SLhivFIpjp.* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, I've lost track of whether this is known and whether the fix
exists and just hasn't been applied etc.

Symptom :

tar Mxvf /dev/fd0 immediately returns with a request for volume #2.

2.5.37 was OK, .38/39 are broken

regards
john
-- 
"When your name is Winner, that's it. You don't need a nickname."
	- Loser Lane
