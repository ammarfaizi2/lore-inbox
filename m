Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751302AbWJWDTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbWJWDTO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 23:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751337AbWJWDTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 23:19:14 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:22428 "EHLO
	asav11.insightbb.com") by vger.kernel.org with ESMTP
	id S1751302AbWJWDTM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 23:19:12 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ah4FAFHQO0VKhRUUXWdsb2JhbACBTIpLLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: =?iso-8859-2?q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: Re: [PATCH] input: init struct serio_bus at compile time
Date: Sun, 22 Oct 2006 23:19:00 -0400
User-Agent: KMail/1.9.3
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <453C1946.1080803@freemail.hu>
In-Reply-To: <453C1946.1080803@freemail.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200610222319.00675.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 October 2006 21:22, Németh Márton wrote:
> From: Márton Németh <nm127@freemail.hu>
> 
> Initialize serio_bus structure at compile time instead of at runtime in serio_init().
> This will speed up startup a little bit and also reduce code size.
> 
> Signed-off-by: Márton Németh <nm127@freemail.hu>
> 

Will apply, thank you.

-- 
Dmitry
