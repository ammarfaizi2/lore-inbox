Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262323AbVGFQkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262323AbVGFQkE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbVGFQgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:36:01 -0400
Received: from wproxy.gmail.com ([64.233.184.194]:40539 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262179AbVGFMZ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 08:25:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Lav7P+KVuzjhngO7eCkQJnxU/AfrG7yHH6mUKDuSJRcAgfXbh8dtBFGfjiF5Q9q0vCX6Z04ZYP6efVzCI8hO5IZVNvoq4LFbfVQ0bQlgJVTYYPZ7C9Bjj4FRnPhpnw2dMgw2M5AM9vzFBS9B/z/eKafsteDqsao3tbDedFEzltE=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ondrej Zary <linux@rainbow-software.org>
Subject: Re: pf: Oops with Imation SuperDisk
Date: Wed, 6 Jul 2005 16:32:05 +0400
User-Agent: KMail/1.8.1
Cc: linux-parport@lists.infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42C7D039.4070006@rainbow-software.org>
In-Reply-To: <42C7D039.4070006@rainbow-software.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507061632.05560.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 July 2005 15:47, Ondrej Zary wrote:
> I've tried to use my external Imation SuperDisk parallel port drive in 
> Linux 2.6.12 but failed.

I've filed a bug at kernel bugzilla so your report won't be lost.
See http://bugme.osdl.org/show_bug.cgi?id=4853

You can register at http://bugme.osdl.org/createaccount.cgi and add yourself
to CC list.
