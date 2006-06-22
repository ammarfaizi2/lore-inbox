Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751582AbWFVEFT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbWFVEFT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 00:05:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932764AbWFVEFS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 00:05:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751582AbWFVEFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 00:05:17 -0400
Date: Wed, 21 Jun 2006 21:05:04 -0700
From: Andrew Morton <akpm@osdl.org>
To: Alasdair G Kergon <agk@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/15] dm: add exports
Message-Id: <20060621210504.b1f387bd.akpm@osdl.org>
In-Reply-To: <20060621193657.GA4521@agk.surrey.redhat.com>
References: <20060621193657.GA4521@agk.surrey.redhat.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006 20:36:57 +0100
Alasdair G Kergon <agk@redhat.com> wrote:

> Export core device-mapper functions for manipulating mapped devices
> and their tables and move them to <linux/device-mapper.h>.
> 

Twenty new exports.  What are they all for?
