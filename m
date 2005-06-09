Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262289AbVFIGzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262289AbVFIGzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 02:55:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262304AbVFIGzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 02:55:39 -0400
Received: from mail.dvmed.net ([216.237.124.58]:40404 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262289AbVFIGzg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 02:55:36 -0400
Message-ID: <42A7E7DF.6040903@pobox.com>
Date: Thu, 09 Jun 2005 02:55:27 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Grant Coady <grant_lkml@dodo.com.au>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SATA NCQ #4
References: <20050608102857.GC18490@suse.de> <qrjda1h0sbohfdi5t57rqpp581avqcslir@4ax.com> <20050608114150.GE18490@suse.de> <20050608114526.GF18490@suse.de> <tbgea15ls0a5kovgnsr62fkhtgnspmjfeg@4ax.com> <20050609062338.GC5140@suse.de> <20050609064031.GF5140@suse.de> <42A7E52E.5040101@pobox.com>
In-Reply-To: <42A7E52E.5040101@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually I wound up removing the WARN_ON(), since it broke my CONFIG_SMP 
build here :)

	Jeff



