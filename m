Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932566AbWFHIpD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932566AbWFHIpD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 04:45:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932568AbWFHIpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 04:45:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:30148 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932566AbWFHIpB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 04:45:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=bq3qvwF0nD3rM7or2Vdjps5Ty4ITVCVvC7VQZ8VQ0rvmfaaRIdFRQw66jCeE7DVfXIVz8HdJmtrNW/5dnstTpbOArWvO+RiHfTsjYEs0xkqczS98LDGXlXviZrdGI//swteUaqjixdDY9GpDYrKqOOkq4tlkTLJVDnka6EbVGYQ=
Message-ID: <dc1166600606080144s5181010doc01d4dc54b239960@mail.gmail.com>
Date: Thu, 8 Jun 2006 18:44:59 +1000
From: "Michael Ellerman" <michael@ellerman.id.au>
To: "Andrew Morton" <akpm@osdl.org>
Subject: please merge make-printk-work-for-really-early-debugging.patch (was: Re: 2.6.18 -mm merge plans)
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Google-Sender-Auth: 0c964e27a666865e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/06, Andrew Morton <akpm@osdl.org> wrote:
>
> It's time to take a look at the -mm queue for 2.6.18.

> make-printk-work-for-really-early-debugging.patch

I have powerpc patches which depend on this one, please send it to
Linus when the flood gates open. Assuming no one has issues with it.

cheers
