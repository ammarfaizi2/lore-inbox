Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbWJBQoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbWJBQoc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 12:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWJBQoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 12:44:32 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:58832 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S965086AbWJBQob (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 12:44:31 -0400
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
From: Lee Revell <rlrevell@joe-job.com>
To: Alessandro Suardi <alessandro.suardi@gmail.com>
Cc: Norbert Preining <preining@logic.at>, hostap@shmoo.com,
       ipw3945-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
References: <20061002085942.GA32387@gamma.logic.tuwien.ac.at>
	 <5a4c581d0610020221s7bf100f8q893161b7c8c492d2@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 12:44:42 -0400
Message-Id: <1159807483.4067.150.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-02 at 09:21 +0000, Alessandro Suardi wrote:
>   we've been just through an email thread where it has been
>   determined that wpa_supplicant 0.4.9 (I would assume that
>   0.5.5 is also okay) and wireless-tools from Jean's latest
>   tarball are necessary to work with the recent wireless
>   extensions v21 that have been merged in.
> 
> What wireless-tools are you using ? 

This must be considered a kernel bug - it's not allowed to break
userspace compatibility in a stable series.

Lee

