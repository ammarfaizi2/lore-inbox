Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbTD1Olw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 10:41:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbTD1Olw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 10:41:52 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:30471 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S261158AbTD1Olv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 10:41:51 -0400
Subject: Re: [PATCH] 2.4.21-rc1 fs/ext3/super.c fix for orphan recovery
	error path
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ernie Petrides <petrides@redhat.com>
Cc: Andrew Morton <akpm@digeo.com>,
       "Marcelo W. Tosatti" <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200304220151.h3M1pt2u024353@pasta.boston.redhat.com>
References: <200304220151.h3M1pt2u024353@pasta.boston.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1051541637.2021.39.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Apr 2003 15:53:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2003-04-22 at 02:51, Ernie Petrides wrote:

> Marcelo, on Andrew's recommendation, I have included a 2.4-based patch
> below for your convenience.

Ack.  Marcelo, please apply.

--Stephen

