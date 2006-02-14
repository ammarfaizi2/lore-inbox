Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422632AbWBNQaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422632AbWBNQaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422631AbWBNQaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:30:46 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:54736 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1422632AbWBNQaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:30:46 -0500
Subject: Re: Problems with sound on latest kernels.
From: Lee Revell <rlrevell@joe-job.com>
To: Lz <elezeta@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <cde01ae70602140558g6440af40mf59e3e1992088d3b@mail.gmail.com>
References: <cde01ae70602140558g6440af40mf59e3e1992088d3b@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 11:30:40 -0500
Message-Id: <1139934640.11659.95.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.90 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-14 at 14:58 +0100, Lz wrote:
> Hello,
> 
> I can't manage to get my sound cards (SB VIBRA and SB AWE 32) working
> on the latest kernels (> 2.6.14 approximately).
> 

Please use ALSA CVS to do a binary search by date to identify the change
that broke it.

Lee

