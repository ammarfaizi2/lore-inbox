Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267478AbUJRS4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267478AbUJRS4n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 14:56:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUJRSzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 14:55:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:45987 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267335AbUJRSqE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 14:46:04 -0400
Message-ID: <41740F59.40906@pobox.com>
Date: Mon, 18 Oct 2004 14:45:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, ak@suse.de, axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com> <20041016171458.4511ad8b.akpm@osdl.org> <4171C20D.1000105@pobox.com> <4171C9CD.4000303@yahoo.com.au> <4171D5F8.8050504@pobox.com>
In-Reply-To: <4171D5F8.8050504@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest Linus merge into 2.6.9-final-bk definitely fixes the hang, 
and seems to work on all the boxes I can readily reboot and test with.

	Jeff



