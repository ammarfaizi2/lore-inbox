Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWHKQu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWHKQu1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 12:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbWHKQu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 12:50:27 -0400
Received: from webmailv3.ispgateway.de ([80.67.16.113]:7868 "EHLO
	webmailv3.ispgateway.de") by vger.kernel.org with ESMTP
	id S1750806AbWHKQu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 12:50:27 -0400
Message-ID: <1155315004.44dcb53c88523@domainfactory-webmail.de>
Date: Fri, 11 Aug 2006 18:50:04 +0200
From: Clemens Ladisch <clemens@ladisch.de>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH for review] [31/145] x86_64: Don't print virtual address in HPET initialization
References: <20060810 935.775038000@suse.de> <20060810193544.C653A13B90@wotan.suse.de>
In-Reply-To: <20060810193544.C653A13B90@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 213.238.46.206
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> virtual addresses don't belong into kernel logs for non debugging
> ...
> +++ linux/drivers/char/hpet.c

Very minor nitpick: this file is used on i386, too.


Clemens

