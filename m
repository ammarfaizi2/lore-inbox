Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265521AbUHSLiv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265521AbUHSLiv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUHSLiv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:38:51 -0400
Received: from mail.gmx.de ([213.165.64.20]:57313 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265521AbUHSLil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:38:41 -0400
X-Authenticated: #1725425
Date: Thu, 19 Aug 2004 13:43:55 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: diablod3@gmail.com, kernel@wildsau.enemy.org, linux-kernel@vger.kernel.org,
       schilling@fokus.fraunhofer.de
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-Id: <20040819134355.295edab6.Ballarin.Marc@gmx.de>
In-Reply-To: <1092915160.830.9.camel@krustophenia.net>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	<d577e5690408190004368536e9@mail.gmail.com>
	<1092915160.830.9.camel@krustophenia.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004 07:32:40 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> 
> What restrictions?  Do you have a link?
> 

Probably line 380 and onwards of cdrecord.c in cdrtools cdrtools-2.01a37.

Regards
