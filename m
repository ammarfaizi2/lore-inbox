Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVDEIFI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVDEIFI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 04:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261618AbVDEH7C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 03:59:02 -0400
Received: from terminus.zytor.com ([209.128.68.124]:24241 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261607AbVDEHpQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 03:45:16 -0400
Message-ID: <425241F7.4020300@zytor.com>
Date: Tue, 05 Apr 2005 00:44:55 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] biarch compiler support for i386
References: <42522CB8.1010007@zytor.com> <20050405073828.GD26208@infradead.org>
In-Reply-To: <20050405073828.GD26208@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> Given that the same logic applies to various other ports maybe it should
> go into a common Makefile fragment?

Alas, the *details* are different for each architecture.

	-hpa
