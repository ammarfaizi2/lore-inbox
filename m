Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUKCRrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUKCRrG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 12:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbUKCRrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 12:47:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46221 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261724AbUKCRq4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 12:46:56 -0500
Message-ID: <41891980.6040009@pobox.com>
Date: Wed, 03 Nov 2004 12:46:40 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] deprecate pci_module_init
References: <20041103091039.GA22469@taniwha.stupidest.org>
In-Reply-To: <20041103091039.GA22469@taniwha.stupidest.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> A separate pci_module_init doesn't really exist anymore so we should
> deprecate this.  Whilst we are at it we should insist any (old) users


Wrong.  There are way too many __correct__ drivers to do this at present.

	Jeff


