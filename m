Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265214AbUFRPK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265214AbUFRPK3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 11:10:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265218AbUFRPK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 11:10:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38320 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265214AbUFRPK0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 11:10:26 -0400
Message-ID: <40D305D5.1060006@pobox.com>
Date: Fri, 18 Jun 2004 11:10:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Eriksson <miffe-miffe@telia.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: iswraid for 2.6
References: <40D26A9B.6000104@telia.com>
In-Reply-To: <40D26A9B.6000104@telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Eriksson wrote:
> Does it exist?


No.  ataraid for 2.6 does not exist.  You should be using device mapper.

	Jeff


