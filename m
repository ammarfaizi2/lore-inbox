Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289099AbSA3LDB>; Wed, 30 Jan 2002 06:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289101AbSA3LCv>; Wed, 30 Jan 2002 06:02:51 -0500
Received: from MORGOTH.MIT.EDU ([18.238.2.157]:9090 "EHLO morgoth.mit.edu")
	by vger.kernel.org with ESMTP id <S289099AbSA3LCi>;
	Wed, 30 Jan 2002 06:02:38 -0500
Date: Wed, 30 Jan 2002 06:02:22 -0500
From: Alex Khripin <akhripin@mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Replaces if(x) BUG() with BUG_ON(x)
Message-ID: <20020130110222.GB21996@morgoth.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My apologies, the patch originally posted had some
extraneous material. There is a new patch at the same
address:
http://web.mit.edu/akhripin/Public/bug_on_patch
-Alex Khripin
