Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262374AbTCRNQF>; Tue, 18 Mar 2003 08:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262382AbTCRNQF>; Tue, 18 Mar 2003 08:16:05 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:3856 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262374AbTCRNQE>; Tue, 18 Mar 2003 08:16:04 -0500
Message-ID: <3E771F24.40508@aitel.hist.no>
Date: Tue, 18 Mar 2003 14:29:08 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.65-mm1 small nfs umount problem, also in 64-mm8
References: <20030318031104.13fb34cc.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have some nfs mounts that users are allowed to mount.
That works, but the user can't umount. "Only root can umount..."
I believe the user doing the mount were allowed to umount before.

Helge Hafting

