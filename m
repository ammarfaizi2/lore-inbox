Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964992AbWHWPsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964992AbWHWPsb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 11:48:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964994AbWHWPsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 11:48:31 -0400
Received: from 81-179-62-49.dsl.pipex.com ([81.179.62.49]:1233 "EHLO
	jaguar.linux-grotto.org.uk") by vger.kernel.org with ESMTP
	id S964992AbWHWPsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 11:48:31 -0400
Message-ID: <44EC78CD.9010401@linux-grotto.org.uk>
Date: Wed, 23 Aug 2006 16:48:29 +0100
From: Johan Groth <johan.groth@linux-grotto.org.uk>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Subject: Re: Scsi errors with Megaraid 300-8x
References: <44EB1875.3020403@linux-grotto.org.uk> <44EC73D2.9090302@rtr.ca> <44EC775C.7040003@linux-grotto.org.uk> <Pine.LNX.4.64.0608231145290.15031@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0608231145290.15031@p34.internal.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> Run badblocks in r+w mode on the bad disk and it will force the disk to 
> re-allocate the bad sector if it can.
> 
> Justin.

Is that possible to do in a non-destructive way? I don't want to loose 
all data and apparently I can't back it up either :(.

Regards,
Johan
