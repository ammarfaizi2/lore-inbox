Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751930AbWGAVZN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751930AbWGAVZN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 17:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbWGAVZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 17:25:13 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:60311 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751930AbWGAVZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 17:25:10 -0400
Message-ID: <44A6E935.7050605@gentoo.org>
Date: Sat, 01 Jul 2006 22:29:25 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Arjan van de Ven <arjan@infradead.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Eeek! page_mapcount(page) went negative! (-1)
References: <44A6AB99.8060407@gentoo.org>	 <1151773620.3195.39.camel@laptopd505.fenrus.org>	 <1151775860.12026.7.camel@mindpipe>	 <1151775918.3195.52.camel@laptopd505.fenrus.org> <1151777485.12026.16.camel@mindpipe>
In-Reply-To: <1151777485.12026.16.camel@mindpipe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> Wow.  It boggles my mind that people try to get away with this.

Sorry for the noise.. it appears likely that this is a nvidia driver issue.

Daniel

