Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbUFSIvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUFSIvg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 04:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUFSIvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 04:51:36 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:26610 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S262009AbUFSIvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 04:51:36 -0400
Date: Sat, 19 Jun 2004 10:51:25 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Hamie <hamish@travellingkiwi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: acpi S3 never wakes up
Message-ID: <20040619085124.GC8930@k3.hellgate.ch>
Mail-Followup-To: Hamie <hamish@travellingkiwi.com>,
	linux-kernel@vger.kernel.org
References: <20040618154025.15708106@damned.travellingkiwi.com> <40D34F90.1060907@travellingkiwi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D34F90.1060907@travellingkiwi.com>
X-Operating-System: Linux 2.6.7-rc3-bk6 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004 21:24:48 +0100, Hamie wrote:
> Can anyone give me a hint as to where the kernel should be 
> re-initialising the video?

Have you checked Documentation/power/video.txt? It's not terribly
encouraging, but it may give you some answers.

Roger
