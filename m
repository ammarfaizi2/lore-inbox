Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261912AbVEQTe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261912AbVEQTe4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 15:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVEQTeb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 15:34:31 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:53425 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261788AbVEQTcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 15:32:48 -0400
Subject: Re: software mixing in alsa
From: Lee Revell <rlrevell@joe-job.com>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050517192412.GA19431@kestrel.twibright.com>
References: <20050517095613.GA9947@kestrel>
	 <200505171208.04052.jan@spitalnik.net> <20050517141307.GA7759@kestrel>
	 <1116354762.31830.12.camel@mindpipe>
	 <20050517192412.GA19431@kestrel.twibright.com>
Content-Type: text/plain
Date: Tue, 17 May 2005 15:32:47 -0400
Message-Id: <1116358367.32062.11.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 21:24 +0200, Karel Kulhavy wrote:
> Lee Revell wrote:
> 
> > Finally, these questions are all OT for LKML.  Try alsa-user at
> > lists.sf.net and alsa-devel at lists.sf.net.  Also there's a bug
> 
> ALSA is a part of Linux kernel, right? This is linux-kernel. Why
> is it OT here? Doesn't make sense for me.

Well, sort of.  The parts of ALSA you are interested in (software mixing
and volume control) are implemented in userspace.  They live in
alsa-lib.

You should at least cc: alsa-devel (non-subscribers can post) when
posting ALSA related questions to LKML.

Lee

