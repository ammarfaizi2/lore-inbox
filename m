Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVC2Dkc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVC2Dkc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 22:40:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262170AbVC2Dkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 22:40:31 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:16270 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262084AbVC2Dh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 22:37:59 -0500
Subject: Re: How to measure time accurately.
From: Lee Revell <rlrevell@joe-job.com>
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <424779F3.5000306@globaledgesoft.com>
References: <424779F3.5000306@globaledgesoft.com>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 22:37:53 -0500
Message-Id: <1112067474.19014.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 08:58 +0530, krishna wrote:
> Hi All,
> 
> Can any one tell me how to measure time accurately for a block of C code 
> in device drivers.
> For example, If I want to measure the time duration of firmware download.

rdtsc()



