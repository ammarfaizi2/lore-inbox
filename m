Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265780AbUGDV0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265780AbUGDV0j (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 17:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265787AbUGDV0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 17:26:38 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:15064 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265780AbUGDV0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 17:26:37 -0400
Message-ID: <40E875FB.5060403@pobox.com>
Date: Sun, 04 Jul 2004 17:26:19 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Danny ter Haar <dth@ncc1701.cistron.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH,RFT] SATA interrupt handling
References: <40E77352.5090703@pobox.com> <cc9s6v$bnm$1@news.cistron.nl>
In-Reply-To: <cc9s6v$bnm$1@news.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Danny ter Haar wrote:
> Jeff Garzik  <jgarzik@pobox.com> wrote:
> 
>>Attached is the latest SATA patch (and BK info).
> 
> 
> 2.6.7-bk17 & your patches works fine on the ICH5
> which had problems with kernels above -bk6 (unless 
> i used acpi=off).

Linus just committed this, thanks for testing.

	Jeff



