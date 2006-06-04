Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750777AbWFDRKY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777AbWFDRKY (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 13:10:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWFDRKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 13:10:24 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:25539 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750777AbWFDRKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 13:10:24 -0400
Subject: Re: SMP HT + USB2.0 crash
From: Lee Revell <rlrevell@joe-job.com>
To: Olaf Hering <olh@suse.de>
Cc: davor emard <davoremard@gmail.com>, Con Kolivas <kernel@kolivas.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20060604145420.GA26218@suse.de>
References: <beee72200606040322w2960e5f9j1716addc39949ccb@mail.gmail.com>
	 <200606042142.01879.kernel@kolivas.org>
	 <beee72200606040729u4c660583g1b7e669b85db5bca@mail.gmail.com>
	 <20060604145420.GA26218@suse.de>
Content-Type: text/plain
Date: Sun, 04 Jun 2006 13:10:21 -0400
Message-Id: <1149441021.30785.10.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-06-04 at 16:54 +0200, Olaf Hering wrote:
>  On Sun, Jun 04, davor emard wrote:
> 
> > It happens on a production machine :(
> 
> Either hire a professional sysadmin, or disable CONFIG_PREEMPT

Um, he said "production machine" not "web server".  There are lots of
applications that require preemption.

Lee

