Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262168AbUKQFGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262168AbUKQFGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 00:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbUKQFGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 00:06:01 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44177 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262168AbUKQFF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 00:05:58 -0500
Message-ID: <419ADC2A.8020007@pobox.com>
Date: Wed, 17 Nov 2004 00:05:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: linux-kernel@vger.kernel.org, mlord@pobox.com, linville@tuxdriver.com
Subject: Re: [IDE] new driver: ADMA
References: <20041117045809.GA1792@havoc.gtf.org>
In-Reply-To: <20041117045809.GA1792@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

oh, and a quick data point:  ata_adma.c is a non-queueing driver (for now).

