Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266933AbSKUSRn>; Thu, 21 Nov 2002 13:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266938AbSKUSRn>; Thu, 21 Nov 2002 13:17:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32782 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266933AbSKUSRm>;
	Thu, 21 Nov 2002 13:17:42 -0500
Message-ID: <3DDD24E7.4040603@pobox.com>
Date: Thu, 21 Nov 2002 13:24:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kent Borg <kentborg@borg.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
References: <20021121125240.K16336@borg.org>
In-Reply-To: <20021121125240.K16336@borg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kent Borg wrote:

> What happened to this feature?  Was it too slow or buggy?  Did the
> Federales force its removal?
>
> (Would this be best implemented as a background scrub and I am missing
> a daemon?)


man shred(1)

Much better than anything implemented in-kernel

	Jeff



