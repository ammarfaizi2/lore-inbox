Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265649AbSLCUZz>; Tue, 3 Dec 2002 15:25:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265657AbSLCUZz>; Tue, 3 Dec 2002 15:25:55 -0500
Received: from franka.aracnet.com ([216.99.193.44]:48795 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265649AbSLCUZy>; Tue, 3 Dec 2002 15:25:54 -0500
Date: Tue, 03 Dec 2002 12:33:23 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: lkml, bugme.osdl.org?
Message-ID: <95600000.1038947602@titus>
In-Reply-To: <200212030724.gB37O4DL001318@turing-police.cc.vt.edu>
References: <200212030724.gB37O4DL001318@turing-police.cc.vt.edu>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Out of curiosity, is it preferred that if bugs/patches get found, that
> they be posted here, to the Bugzilla database, or both?  I've been
> putting them at both places, so there's discussion here and a history
> there...

I'd say both. Be careful not to file duplicates in Bugzilla though.
People attatching patches to existing bugs in Bugzilla are especially
welcome ;-)

Bugs will get closed out once they're fixed in the next full release
of mainline, so Bugzilla shouldn't get too cluttered. We need to have
a better (more searchable) version field, but that needs some more
complex Bugzilla rework ... we're thinking about how best to do it.

M.

