Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262690AbTCPRAT>; Sun, 16 Mar 2003 12:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262691AbTCPRAT>; Sun, 16 Mar 2003 12:00:19 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:43783 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S262690AbTCPRAT>; Sun, 16 Mar 2003 12:00:19 -0500
Message-ID: <3E74B088.10907@aitel.hist.no>
Date: Sun, 16 Mar 2003 18:12:40 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.64-mm8
References: <20030316024239.484f8bda.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mm8 is good, anticipatory scheduling seems to work fine with
software raid 0 & 1 now. :-)
It seems to boot noticeably quicker than mm2,
possibly a result of the memory mapping speedup.

Helge Hafting

