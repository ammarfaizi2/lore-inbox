Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030338AbWEZEVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030338AbWEZEVc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 00:21:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030378AbWEZEVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 00:21:04 -0400
Received: from xenotime.net ([66.160.160.81]:8131 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030340AbWEZEUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 00:20:34 -0400
Date: Thu, 25 May 2006 21:23:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Xin Zhao" <uszhaoxin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: why svc_export_lookup() has no implementation?
Message-Id: <20060525212307.376a4ee6.rdunlap@xenotime.net>
In-Reply-To: <4ae3c140605252115n7b040a99l6633ba387ce48358@mail.gmail.com>
References: <4ae3c140605252115n7b040a99l6633ba387ce48358@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2006 00:15:32 -0400 Xin Zhao wrote:

> I noticed that functions like exp_get_by_name() calls function
> svc_export_lookup(). But I cannot find the implementation of
> svc_export_lookup(). I can only find the function definition. HOw can
> this happen?
> 
> Can someone give me a hand?

Sounds like you need better tools or get them to search like
you mean for them to search.

seee fs/nfsd/export.c

---
~Randy
