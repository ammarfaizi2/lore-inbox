Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbTJAW5E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 18:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262669AbTJAW5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 18:57:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:11411 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262667AbTJAW5D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 18:57:03 -0400
Date: Wed, 1 Oct 2003 15:56:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vinay K Nallamothu <vinay.nallamothu@gsecone.com>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test6][X25] timer cleanup
Message-Id: <20031001155623.06b89258.akpm@osdl.org>
In-Reply-To: <1065018387.7194.336.camel@lima.royalchallenge.com>
References: <1065018387.7194.336.camel@lima.royalchallenge.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vinay K Nallamothu <vinay.nallamothu@gsecone.com> wrote:
>
> Replace del_timer, mod_timer sequences with mod_timer.

was this tested?
