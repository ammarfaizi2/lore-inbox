Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316999AbSGCLkT>; Wed, 3 Jul 2002 07:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317002AbSGCLkS>; Wed, 3 Jul 2002 07:40:18 -0400
Received: from ws-002.ray.fi ([193.64.14.2]:35632 "EHLO behemoth.ts.ray.fi")
	by vger.kernel.org with ESMTP id <S316999AbSGCLkR>;
	Wed, 3 Jul 2002 07:40:17 -0400
Date: Wed, 3 Jul 2002 14:42:42 +0300 (EEST)
From: Tommi Kyntola <kynde@ts.ray.fi>
X-X-Sender: kynde@behemoth.ts.ray.fi
To: linux-kernel@vger.kernel.org
Subject: 2.4.19-rc1: mouse clicks broken in X (atleast)
Message-ID: <Pine.LNX.4.44.0204161148550.30988-100000@behemoth.ts.ray.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not sure wether this has already been reported in some
other thread or if it's a known issue, but I'm
experienceing some really weird mouse behaviour in X
with the 2.4.19-rc1. 

This is a new issue since nothing similar has not occured
with any 19-preX or 19-preX-acX patches.

With weird behaviour I mean mouse clicks dont pass through
to wm as single clicks (apparently as occasional double clicks).
I'm not going to look into this any further right now as I'm 
hoping that the person behind changes can sort it out even
with this minimal information. Movement seems normal though.

If more information or research regarding the problem
is needed/hoped-for, please just ask. For now I'll just
stick to pre10-ac2

-- 
Tommi Kynde Kyntola		kynde@ts.ray.fi
      "A man alone in the forest talking to himself and
       no women around to hear him. Is he still wrong?"






