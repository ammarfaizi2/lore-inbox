Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbUBZER7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 23:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbUBZER7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 23:17:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46550 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262678AbUBZERn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 23:17:43 -0500
Message-ID: <403D7359.6080107@pobox.com>
Date: Wed, 25 Feb 2004 23:17:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Promise SATA driver
References: <200402241110.07526.andrew@walrond.org> <20040224154446.GA28720@ee.oulu.fi> <403B73E3.80100@pobox.com> <200402241630.36105.andrew@walrond.org> <403B8028.1060700@pobox.com> <s5gy8qqzdso.fsf@patl=users.sf.net>
In-Reply-To: <s5gy8qqzdso.fsf@patl=users.sf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick J. LoPresti wrote:
> Jeff Garzik <jgarzik@pobox.com> writes:
> 
> 
>>In 2.6, Promise software RAID support does not exist.  In
>>conversations with Promise, we all agreed to encourage and support
>>the standard Linux RAID, md.
> 
> 
> Does this mean a dual-boot Linux/Windows system cannot use a Promise
> RAID?


In 2.4, you can use pdcraid driver.

In 2.6, correct, there is no Promise RAID driver.

	Jeff



