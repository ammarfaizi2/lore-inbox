Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269418AbUINPHU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269418AbUINPHU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 11:07:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269425AbUINPHT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 11:07:19 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58836 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269418AbUINPGc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 11:06:32 -0400
Message-ID: <414708E5.6020006@pobox.com>
Date: Tue, 14 Sep 2004 11:06:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add skeleton "generic IO mapping" infrastructure.
References: <200409132206.i8DM6dSC030620@hera.kernel.org>	 <1095152147.9144.254.camel@imladris.demon.co.uk>	 <41470074.9010900@pobox.com> <1095172422.24547.185.camel@hades.cambridge.redhat.com>
In-Reply-To: <1095172422.24547.185.camel@hades.cambridge.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse wrote:
> On Tue, 2004-09-14 at 10:30 -0400, Jeff Garzik wrote:
> 
>>Override it in your arch if you don't like the generic version ;-)
> 
> 
> If you must... but make it take a cookie with enough space to give the
> required information -- not just an unsigned long.


If you have (device, address) you should have all you need...

	Jeff


