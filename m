Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbUARSrK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 13:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263600AbUARSrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 13:47:09 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:27403 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263544AbUARSrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 13:47:07 -0500
Date: Sun, 18 Jan 2004 13:47:03 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Pavel Machek <pavel@ucw.cz>
cc: Valdis.Kletnieks@vt.edu, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: sched-idle and disk-priorities for 2.6.X
In-Reply-To: <20040117232926.GC9999@elf.ucw.cz>
Message-ID: <Pine.LNX.4.44.0401181346480.28955-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Jan 2004, Pavel Machek wrote:

> Is there effective way to limit RSS?

Want me to port the RSS stuff from 2.4-rmap to 2.6 ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

