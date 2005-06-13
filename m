Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261620AbVFMWw1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261620AbVFMWw1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 18:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVFMWfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 18:35:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39058 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261585AbVFMWec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 18:34:32 -0400
Date: Mon, 13 Jun 2005 15:35:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: video4linux-list@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH4/5] Synchronize patch for documentation
Message-Id: <20050613153510.2703e2fa.akpm@osdl.org>
In-Reply-To: <42ABC420.6070008@brturbo.com.br>
References: <42ABC011.1030307@brturbo.com.br>
	<42ABC420.6070008@brturbo.com.br>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@brturbo.com.br> wrote:
>
> Now, with attach :-)
> 
> Mauro Carvalho Chehab wrote:
> 
> >Syncronizing V4L documentation and including V4L2 API.
> >

Something obviously went wrong with this patch:

 25-akpm/Documentation/video4linux/CARDLIST.saa7134 |    2 
 25-akpm/Documentation/video4linux/CARDLIST.tuner   |    1 
 25-akpm/Docummentation/video4linux/V4L1_API.html   |  399 
 25-akpm/Docummentation/video4linux/V4L2_API.html   |39663 +++++++++++++++++++++
 Documentation/video4linux/bttv/Cards               |    0 

Please redo and resend.
