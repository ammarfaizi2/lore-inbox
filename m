Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261540AbVCaQWH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVCaQWH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 11:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVCaQWG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 11:22:06 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:5775 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261540AbVCaQWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 11:22:04 -0500
Subject: Re: Poor SATA / RAID performance (2.6.11 and promise SATAII150 TX4)
From: Lee Revell <rlrevell@joe-job.com>
To: Tim Harvey <tim_harvey@yahoo.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050331031250.42410.qmail@web30511.mail.mud.yahoo.com>
References: <20050331031250.42410.qmail@web30511.mail.mud.yahoo.com>
Content-Type: text/plain
Date: Thu, 31 Mar 2005 11:22:03 -0500
Message-Id: <1112286123.1829.0.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-30 at 19:12 -0800, Tim Harvey wrote:
>   - the number of interrupts per second (1023) seems very high

Why?  You have 1000 timer interrupts every second, plus 23 from other
sources.

Lee

