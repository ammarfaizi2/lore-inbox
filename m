Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261302AbVDDRqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261302AbVDDRqx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVDDRqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:46:53 -0400
Received: from srusmtp2.sru.edu ([205.149.70.103]:40060 "EHLO
	ssfdns02.srunet.sruad.edu") by vger.kernel.org with ESMTP
	id S261302AbVDDRqv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:46:51 -0400
Date: Mon, 4 Apr 2005 13:43:27 -0400
To: Arun Srinivas <getarunsri@hotmail.com>
Cc: rostedt@goodmis.org, linux-kernel@vger.kernel.org
Subject: Re: setting cpu affinity-help
Message-ID: <20050404174327.GA1718@mars>
References: <BAY10-F19099E77C7F764C06CBC07D93A0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BAY10-F19099E77C7F764C06CBC07D93A0@phx.gbl>
User-Agent: Mutt/1.5.6+20040907i
From: a.othieno@bluewin.ch (Arthur Othieno)
X-OriginalArrivalTime: 04 Apr 2005 17:43:52.0740 (UTC) FILETIME=[DDD46640:01C5393D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 08:46:12AM +0530, Arun Srinivas wrote:
> hi
> 
> can someone show me an example usage of sched_setaffinity().I do not know 
> how to set the affinity mask for a process.please.
> 
> thanks
> arun
 
http://www.linuxjournal.com/article/6799

Section "Affinity Masks"

Hope that helps,

	Arthur
