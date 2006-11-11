Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424593AbWKKTEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424593AbWKKTEV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 14:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424595AbWKKTEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 14:04:21 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:58379 "EHLO
	smtp-vbr1.xs4all.nl") by vger.kernel.org with ESMTP
	id S1424593AbWKKTEV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 14:04:21 -0500
Date: Sat, 11 Nov 2006 20:04:09 +0100
From: thunder7@xs4all.nl
To: jurriaan <thunder7@xs4all.nl>
Cc: neilb@suse.de, linux-kernel@vger.kernel.org
Subject: Re: trouble with mounting a 1.5 TB raid6 volume in 2.6.19-rc5-mm1
Message-ID: <20061111190409.GA5950@amd64.of.nowhere>
Reply-To: Jurriaan <thunder7@xs4all.nl>
References: <20061111183835.GA3801@amd64.of.nowhere>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061111183835.GA3801@amd64.of.nowhere>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: jurriaan <thunder7@xs4all.nl>
Date: Sat, Nov 11, 2006 at 07:38:35PM +0100
> I have a 8 disk 1.5 TB raid6 volume that won't mount in 2.6.19-rc5-mm1.

This is 2.6.19-rc5-mm1 with 

md-change-lifetime-rules-for-md-devices.patch

reverted, of course, otherwise it won't boot.

Jurriaan
-- 
I never think, sir. Didn't get a degree.
	Chief Inspector Morse
Debian (Unstable) GNU/Linux 2.6.19-rc5-mm1 2x4826 bogomips load 2.59
