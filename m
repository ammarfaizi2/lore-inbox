Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbWHBVJy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWHBVJy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 17:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWHBVJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 17:09:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60090 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932127AbWHBVJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 17:09:53 -0400
Date: Wed, 2 Aug 2006 14:09:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: balbir@in.ibm.com
Cc: Shailabh Nagar <nagar@watson.ibm.com>, Jay Lan <jlan@sgi.com>,
       lkml <linux-kernel@vger.kernel.org>, Jes Sorensen <jes@sgi.com>,
       Chris Sturtivant <csturtiv@sgi.com>, Tony Ernst <tee@sgi.com>
Subject: Re: [patch 1/3] add basic accounting fields to taskstats
Message-Id: <20060802140945.de650d95.akpm@osdl.org>
In-Reply-To: <44D0DE13.7090205@in.ibm.com>
References: <44CE57EF.2090409@sgi.com>
	<44CF6433.50108@in.ibm.com>
	<44CFCCE4.7060702@sgi.com>
	<44D0C56C.3030505@watson.ibm.com>
	<44D0DE13.7090205@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Aug 2006 22:47:07 +0530
Balbir Singh <balbir@in.ibm.com> wrote:

> I am not sure if there is a version of BUG_ON() for compile time
> asserts

We have BUILD_BUG_ON()
