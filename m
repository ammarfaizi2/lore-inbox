Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264325AbTLPEKj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 23:10:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264326AbTLPEKj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 23:10:39 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:18912 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264325AbTLPEKi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 23:10:38 -0500
Date: Mon, 15 Dec 2003 20:10:17 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: edjard@ufam.edu.br, Rik van Riel <riel@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Calculating total slab memory on 2.2/2.0 (was: More questions about 2.6 /proc/meminfo was: (Mem: and Swap: lines in /proc/meminfo))
Message-ID: <20031216041017.GE1769@matchmail.com>
Mail-Followup-To: edjard@ufam.edu.br, Rik van Riel <riel@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20031214014429.GB1769@matchmail.com> <Pine.LNX.4.44.0312141915550.26386-100000@chimarrao.boston.redhat.com> <20031215185701.GC1769@matchmail.com> <33772.200.212.156.130.1071517210.squirrel@webmail.ufam.edu.br> <20031215215717.GD1769@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031215215717.GD1769@matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.4 with slabinfo format version 1.1, I can sum up the total pages used
for all slab caches, but the number of pages used is not in the 1.0 format
(in the 2.2 kernel).

Is there a way to get the total amount of slab cache memory used in a 2.2
kernel from userspace?

Same question for a 2.0 kernel too. :)

Thanks,

Mike
