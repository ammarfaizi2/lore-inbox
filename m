Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318951AbSH1UgM>; Wed, 28 Aug 2002 16:36:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318952AbSH1UgM>; Wed, 28 Aug 2002 16:36:12 -0400
Received: from dsl-213-023-022-149.arcor-ip.net ([213.23.22.149]:40395 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318951AbSH1UgL>;
	Wed, 28 Aug 2002 16:36:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Subject: Re: MM patches against 2.5.31
Date: Wed, 28 Aug 2002 22:41:49 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D644C70.6D100EA5@zip.com.au> <E17jjWN-0002fo-00@starship> <20020828131445.25959.qmail@thales.mathematik.uni-ulm.de>
In-Reply-To: <20020828131445.25959.qmail@thales.mathematik.uni-ulm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17k9dO-0002tR-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Going right back to basics, what do you suppose is wrong with the 2.4 
strategy of always doing the lru removal in free_pages_ok?

-- 
Daniel
