Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263563AbUECCqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263563AbUECCqO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 22:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263576AbUECCqO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 22:46:14 -0400
Received: from relay02.roc.ny.frontiernet.net ([66.133.131.35]:44775 "EHLO
	relay02.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S263563AbUECCqD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 22:46:03 -0400
Message-ID: <4095B242.2060001@xfs.org>
Date: Sun, 02 May 2004 21:45:22 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Journaling File Sstem Question
References: <BAY18-F4FXfyY0QUUBP00002758@hotmail.com>
In-Reply-To: <BAY18-F4FXfyY0QUUBP00002758@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> Concerning JFS vs REISERFS vs XFS...
> 
> Which would one use for stability?
> 
> I realize XFS has been in use probably longer than the other two on 
> SGI's, but in Linux it was only recently merged into the 2.4.xx kernel.
> 
> However, ReiserFS has been in the 2.4 kernel since the early 2.4.x 
> series, JFS on the other hand is somewhere in the middle.

XFS was out there for a couple of years before it was merged. XFS was
out there before reiserfs was merged, we first released against 2.3.43
from my memory.

There is a timeline here:

http://oss.sgi.com/projects/xfs/news.html

XFS went a lot of places before it went into the 2.4 kernel, it has been
in 2.6 for over a year for starters.

Steve

