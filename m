Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269032AbUJQDjw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269032AbUJQDjw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 23:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269038AbUJQDjw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 23:39:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9674 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269032AbUJQDju
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 23:39:50 -0400
Message-ID: <4171E978.6060207@pobox.com>
Date: Sat, 16 Oct 2004 23:39:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ak@suse.de, axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com>	<20041016171458.4511ad8b.akpm@osdl.org>	<4171C20D.1000105@pobox.com> <20041016182116.33b3b788.akpm@osdl.org>
In-Reply-To: <20041016182116.33b3b788.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> vmscan-total_scanned-fix.patch


Yes, this patch also seems to solve the hang.

Do you want me to test further?

	Jeff


