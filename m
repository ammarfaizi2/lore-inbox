Return-Path: <linux-kernel-owner+w=401wt.eu-S1751647AbWLMWKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbWLMWKr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 17:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbWLMWKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 17:10:47 -0500
Received: from smtp.osdl.org ([65.172.181.25]:48522 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751635AbWLMWKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 17:10:46 -0500
Date: Wed, 13 Dec 2006 14:10:36 -0800
From: Andrew Morton <akpm@osdl.org>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Linux Containers <containers@lists.osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/12] tty layer and misc struct pid conversions
Message-Id: <20061213141036.f8cac5e7.akpm@osdl.org>
In-Reply-To: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
References: <m1y7pcoy5w.fsf@ebiederm.dsl.xmission.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 04:03:39 -0700
ebiederm@xmission.com (Eric W. Biederman) wrote:

> The aim of this patch set is to start wrapping up the struct pid
> conversions.

hm, it touches a lot of tricky code which few people are familar
with.  Worried.
