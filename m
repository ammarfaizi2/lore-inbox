Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262684AbVAFCSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262684AbVAFCSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 21:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVAFCSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 21:18:17 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:33431 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S262684AbVAFCSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 21:18:16 -0500
Message-ID: <41DC9FE3.3040005@f2s.com>
Date: Thu, 06 Jan 2005 02:18:11 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Mozilla Thunderbird 1.0 (X11/20041211)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Nelson <james4765@cwazy.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm26: update irq handling code in arch/arm26/machine/dma.c
References: <20050105015946.22220.43127.86751@localhost.localdomain>
In-Reply-To: <20050105015946.22220.43127.86751@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Nelson wrote:
> Remove to-be-deprecated function save_flags() and nonexistent function local_save_flags_cli()
> 
> Signed-off-by: James Nelson <james4765@gmail.com>

I've applied this to my tree.

About the signing off thing - do I assume that since its posted here, 
someone else will forward it on, or should I sign off on it and send it 
to who I think it should go to?

