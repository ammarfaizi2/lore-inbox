Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751853AbWCVAGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853AbWCVAGj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 19:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWCVAGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 19:06:39 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11991 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751853AbWCVAGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 19:06:38 -0500
Subject: Re: 2.6.16-rc6-ide1 irq trap, io hang problem solved?
From: Lee Revell <rlrevell@joe-job.com>
To: Ed Sweetman <safemode@comcast.net>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
In-Reply-To: <442089CB.1000008@comcast.net>
References: <442089CB.1000008@comcast.net>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 19:06:35 -0500
Message-Id: <1142985995.4532.195.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-03-21 at 18:18 -0500, Ed Sweetman wrote:
> I've seen some traffic here to suggest that the problem was tracked 
> down, but I saw nothing about it being solved completely.  Currently my 
> system hangs whenever an irq trap message appears, usually after some 
> sort of disk io on SATA drives. Is it fixed in the GIT patchset recently 
> posted or is this still open?  

Are you referring to the "Losing ticks" bug?  What is the exact error
message that you get?  Does the system hang momentarily or have to be
rebooted?

Lee

