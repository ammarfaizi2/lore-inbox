Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUIJAcR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUIJAcR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 20:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUIJAcR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 20:32:17 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:31966 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266218AbUIJAcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 20:32:16 -0400
Subject: Re: linux-2.6.9-rc1-bk16 Still cdrom/DVD oops
From: Lee Revell <rlrevell@joe-job.com>
To: sboyce@blueyonder.co.uk
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4140F3A7.8040103@blueyonder.co.uk>
References: <4140F3A7.8040103@blueyonder.co.uk>
Content-Type: text/plain
Message-Id: <1094776333.1396.31.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 09 Sep 2004 20:32:14 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 20:21, Sid Boyce wrote:
> Sep 10 01:15:11 barrabas kernel: Modules linked in: nvidia parport_pc lp 

Your kernel is tainted.  Please reproduce with an untainted kernel and
report.

Lee

