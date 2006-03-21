Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751592AbWCUMX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751592AbWCUMX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 07:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751591AbWCUMX5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 07:23:57 -0500
Received: from smtp.osdl.org ([65.172.181.4]:30930 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751571AbWCUMX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 07:23:57 -0500
Date: Tue, 21 Mar 2006 04:20:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: mchehab@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org,
       mchehab@infradead.org
Subject: Re: [PATCH 077/141] V4L/DVB (3300b): .gitignore should also ignore
 StGit generated dirs
Message-Id: <20060321042034.0cb01c9a.akpm@osdl.org>
In-Reply-To: <20060320150849.PS878367000077@infradead.org>
References: <20060320150819.PS760228000000@infradead.org>
	<20060320150849.PS878367000077@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mchehab@infradead.org wrote:
>
> StGit genreates patches-* when you run stg export command.
>  It makes no sense to show such directories as changes on git status.

That's not a DVB patch.  Things like this should be submitted separately
please.

