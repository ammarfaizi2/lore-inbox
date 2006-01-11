Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932328AbWAKO2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932328AbWAKO2V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbWAKO2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:28:21 -0500
Received: from nproxy.gmail.com ([64.233.182.192]:39773 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932328AbWAKO2U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:28:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e634rPXzS6jo5k6P8Xd/6ehYS8vUPjvsq7nzDKSS5e4XcLBIvqAhMLVFwilOp69I746/ct//5NQb8qcRHKETsfZQPi7nxv4HCM6OAeUs83bLdI8QegYwoOpqUdZ76/OZmZYSCKka5AHCgR4UE7CL+CL9CBGWybHIgDhzWobXa9Y=
Message-ID: <c216304e0601110627l2d46096fwcf0101ae8e02afcc@mail.gmail.com>
Date: Wed, 11 Jan 2006 19:57:45 +0530
From: Ashutosh Naik <ashutosh.lkml@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.15-mm3
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060111042135.24faf878.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060111042135.24faf878.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/06, Andrew Morton <akpm@osdl.org> wrote:

> - Reminder: -mm kernel commit activity can be reviewed by subscribing to the
>   mm-commits mailing list.
>
>   echo "subscribe mm-commits" | mail marordomo@vger.kernel.org
>

You probably meant

echo "subscribe mm-commits" | mail majordomo@vger.kernel.org
