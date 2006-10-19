Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161391AbWJSKb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161391AbWJSKb4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 06:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161400AbWJSKb4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 06:31:56 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:21589 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161391AbWJSKbz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 06:31:55 -0400
Message-ID: <453755B6.7060507@sw.ru>
Date: Thu, 19 Oct 2006 14:38:46 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Paul Ingram <paul.ingram@ig.co.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: KORG OpenVZ...
References: <200610191014.k9JAEgQj016625@wolf.ig.co.uk>
In-Reply-To: <200610191014.k9JAEgQj016625@wolf.ig.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am requesting that OpenVZ makes it into the main kernel branch.
> 
> It gives me what I need to satisfy my customers requirements (and my own).
> 
> ATM, the only fly in the ointment is installation - with the current stable OpenVZ
> branch being an ancient 2.6.9 kernel, use of my customers shiny new Megaraid
> SATA controller meant I had to use the 2.6.16 OpenVZ dev branch - which is
> *still* an old kernel. There would be no problem if OpenVZ was part of the main
> branch.
OpenVZ 2.6.9 kernel is based on RHEL4 one. it is not ancient.
And BTW, it has the latest megaraid driver. So if you had problems you should have reported
to OpenVZ ML directly. Not here.

Thanks,
Kirill

