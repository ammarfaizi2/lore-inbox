Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269689AbUJGEkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269689AbUJGEkO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 00:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269690AbUJGEkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 00:40:14 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17298 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269689AbUJGEkL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 00:40:11 -0400
Message-ID: <4164C89A.2040408@pobox.com>
Date: Thu, 07 Oct 2004 00:39:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org, alan@redhat.com,
       david.balazic@hermes.si
Subject: Re: [PATCH 2.6.9-rc3-mm2] EDD: use EXTENDED READ command, add CONFIG_EDD_SKIP_MBR
References: <20041004214803.GC2989@lists.us.dell.com>
In-Reply-To: <20041004214803.GC2989@lists.us.dell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alas, this does not eliminate the 30-second delay on my box.

Just to re-emphasize, I feel a particularly relevant detail is that my 
VIA-based Athlon64 box has _all_ PATA ports disabled.

I am fairly certainly that the delay did not exist when I enabled at 
least one PATA port, and I can verify this if you would like.

	Jeff



