Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268100AbUHYEt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268100AbUHYEt0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 00:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268341AbUHYEtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 00:49:25 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:21961 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268100AbUHYEtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 00:49:00 -0400
Subject: Re: PROBLEM: ATAPI (Memory Leak?)
From: Lee Revell <rlrevell@joe-job.com>
To: "Steven E. Woolard" <tuxq@tuxq.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <412C18D2.5080206@tuxq.com>
References: <412C18D2.5080206@tuxq.com>
Content-Type: text/plain
Message-Id: <1093409340.5678.16.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 25 Aug 2004 00:49:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-25 at 00:42, Steven E. Woolard wrote:

> If this has been fixed in an rc or mm patch, let me know--I'll upgrade
> As for now, I'm back on 2.6.7
> 

You don't say which kernel you are using, but this is a known bug.  It
should be fixed in 2.6.9.  Try 2.6.9-rc1 for the time being.

Lee

