Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262186AbVBJSMU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262186AbVBJSMU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 13:12:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbVBJSMU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 13:12:20 -0500
Received: from smtp08.web.de ([217.72.192.226]:7662 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S262184AbVBJSML (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 13:12:11 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NFS (ext3/VFS?) bug in 2.6.8/10
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
References: <20050210173954.67324.qmail@web26501.mail.ukl.yahoo.com>
From: Markus Plail <linux-kernel@gitteundmarkus.de>
Date: Thu, 10 Feb 2005 19:12:58 +0100
In-Reply-To: <20050210173954.67324.qmail@web26501.mail.ukl.yahoo.com> (Neil
 Conway's message of "Thu, 10 Feb 2005 17:39:54 +0000 (GMT)")
Message-ID: <87psz8707p.fsf@plailis.daheim.bs>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Conway <nconway_kernel@yahoo.co.uk> writes:
> We're seeing lots of "No such file or directory" errors (ENOENT)
> coming back from NFS accesses of one of our data server machines.

I can't help you, but just want to say that I also see those errors on a
local xfs file system, so it doesn't seem to be a NFS problem. I was
first seeing this with 2.6.11-rc3-mm1 on a directory with 8k.

regards
Markus

