Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318860AbSICSHb>; Tue, 3 Sep 2002 14:07:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318878AbSICSHb>; Tue, 3 Sep 2002 14:07:31 -0400
Received: from dsl-213-023-043-116.arcor-ip.net ([213.23.43.116]:25493 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318860AbSICSHa>;
	Tue, 3 Sep 2002 14:07:30 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Anton Altaparmakov <aia21@cantab.net>, Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: [BK-PATCH-2.5] Introduce new VFS inode cache lookup function
Date: Tue, 3 Sep 2002 20:14:04 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.SOL.3.96.1020903055423.13331A-100000@libra.cus.cam.ac.uk>
In-Reply-To: <Pine.SOL.3.96.1020903055423.13331A-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17mIBh-0005ip-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 September 2002 07:20, Anton Altaparmakov wrote:
> Thanks for your comments. It is interesting to read everyone's
> suggestions...

One more... 'ifind' would be more in keeping with existing terminology
than 'ilookup'.  (See page cache operations in filemap.c)

-- 
Daniel
