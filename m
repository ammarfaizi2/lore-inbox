Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVFHRkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVFHRkQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 13:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVFHRkC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 13:40:02 -0400
Received: from 203-217-18-197.perm.iinet.net.au ([203.217.18.197]:29880 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261406AbVFHRfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 13:35:52 -0400
Message-ID: <42A72C70.3070802@knobbits.org>
Date: Thu, 09 Jun 2005 03:35:44 +1000
From: "Michael (Micksa) Slade" <micksa@knobbits.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050524 Debian/1.7.8-1ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Subject: Re: Inspiron 6000 / ACPI S3 / PCI-X problems?
References: <42A4969D.9070500@knobbits.org> <42A6B7B8.90000@rtr.ca>
In-Reply-To: <42A6B7B8.90000@rtr.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:

> The i6000 is very similar internally (identical?) to the i9300.
> I have a Dell Inspiron 9300 and *everything* is working perfectly with 
> Linux,
> except for the SD-slot (no driver, no datasheets).
>
> Try my suspend script and other (K)Ubuntu changes:  
> http://rtr.ca/dell_i9300/
>
Thanks.  No dice :(  Apparently the models have some differences 
internally :/

Do me a favor?  Grab lcpsi output under normal conditions, and also just 
between the resume and the "vbetool post"?

Whose job should it be to restore the PCI config? (assuming that's the 
problem)  Which code should I start hacking?

I'll bluddy well scoff the PCIe spec if I have to!

Mick.

