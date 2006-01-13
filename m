Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWAMAsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWAMAsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 19:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932678AbWAMAsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 19:48:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:64980 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932523AbWAMAsI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 19:48:08 -0500
Date: Thu, 12 Jan 2006 16:50:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-kernel@vger.kernel.org, erich@areca.com.tw
Subject: Re: + areca-raid-driver-arcmsr-update2.patch added to -mm tree
Message-Id: <20060112165001.7ca3fea3.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0601111917570.21722@shark.he.net>
References: <200601120312.k0C3Cw80026379@shell0.pdx.osdl.net>
	<Pine.LNX.4.58.0601111917570.21722@shark.he.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> Ugh.  I guess that there was some reason that this patch
> reverts a lot of previous changes...?

erp, sorry.  Erich's patch generated a single 5000-line reject so I kind of
jammed it in and lost some of your changes.  I meant to go back and redo
them on top but haven't got there yet.
