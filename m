Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964957AbWIDTV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964957AbWIDTV1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 15:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWIDTV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 15:21:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10396 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751525AbWIDTV0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 15:21:26 -0400
Date: Mon, 4 Sep 2006 12:18:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Matthew Wilcox <matthew@wil.cx>, Adrian Bunk <bunk@stusta.de>,
       Sukadev Bhattiprolu <sukadev@us.ibm.com>, linux-kernel@vger.kernel.org,
       parisc-linux@parisc-linux.org
Subject: Re: [PATCH] Fix conflict with the is_init identifier on parisc
Message-Id: <20060904121805.d5112dff.akpm@osdl.org>
In-Reply-To: <m164g37an8.fsf_-_@ebiederm.dsl.xmission.com>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060904114130.GN4416@stusta.de>
	<20060904134826.GF2558@parisc-linux.org>
	<m164g37an8.fsf_-_@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Sep 2006 12:24:27 -0600
ebiederm@xmission.com (Eric W. Biederman) wrote:

> Singed-off-by: Eric Biederman <ebiederm@xmission.com>

ouch!  One for the hot-fixes directory, I assume.
