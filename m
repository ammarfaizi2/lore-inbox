Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUH3WbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUH3WbU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 18:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264954AbUH3WbU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 18:31:20 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:4782 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S264881AbUH3W1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 18:27:47 -0400
Subject: Re: [2.6.7] ReiserFS borks with preempt
From: Lee Revell <rlrevell@joe-job.com>
To: Tommy Faasen <tommy@zwanebloem.nl>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <41337F5F.7030503@zwanebloem.nl>
References: <41337F5F.7030503@zwanebloem.nl>
Content-Type: text/plain
Message-Id: <1093904868.1348.16.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 30 Aug 2004 18:27:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-30 at 15:26, Tommy Faasen wrote:
> Hi,

Argh, does anyone READ these before posting them?

Your kernel is tainted.  Please reproduce with an untainted kernel and
repost.

Lee

