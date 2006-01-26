Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWAZX47@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWAZX47 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 18:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWAZX47
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 18:56:59 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:39293 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751230AbWAZX44 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 18:56:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LtNKDic5Al1jWLQ0BUZzYU+UUKx1e2hQZ0ktoSeNELoMpHy5qRxgSfTPUTFwkhxJPKQ1ktSkkoW28JRlYLTk9zzfCW0ceH/sxXDR4XM8LsKrwOT7k1M1NKNzxUhkh/MUpYTYqOUWa1vysNirdZn3hrYR9jfFKUdfoAMkTo0wI1g=
Message-ID: <58cb370e0601261556h727b2828r7216e2a8cb34ea0f@mail.gmail.com>
Date: Fri, 27 Jan 2006 00:56:54 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: kobject_register failed for Promise_Old_IDE (-17)
Cc: linux-kernel@vger.kernel.org, andre@linux-ide.org, frankt@promise.com,
       linux-ide@vger.kernel.org, Vasil Kolev <vasil@ludost.net>
In-Reply-To: <1138175680.5857.4.camel@lyra.home.ludost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1138093728.5828.8.camel@lyra.home.ludost.net>
	 <20060124223527.GA26337@kroah.com>
	 <58cb370e0601241458y6cdf702ey9caa261702a7948a@mail.gmail.com>
	 <1138175680.5857.4.camel@lyra.home.ludost.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem cannot be reproduced now (as reported by
Vasil in private mail) so it seems that it is not a kernel bug.

Bartlomiej
