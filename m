Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932081AbWGKS0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbWGKS0F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 14:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932080AbWGKS0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 14:26:05 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:57206 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932079AbWGKS0D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 14:26:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=d65mKBVQnXsFqa/Qz6/tPDrIfFjacozr+rdJiKZ7RHu/f6+fnWxLHxQ6O2M+QZuHXuenojNwghZeWhU01aBBNeMt3IRyWyBgbigfaCdDFpXsxIqELfqNsykVox2fNpTgtSRbw3E9f/UPikwra+s6nGZmYYLGMQHeWHL80eDPKSk=
Message-ID: <44B3ED29.4040801@gmail.com>
Date: Tue, 11 Jul 2006 21:25:45 +0300
From: Alon Bar-Lev <alon.barlev@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060620)
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: "John W. Linville" <linville@tuxdriver.com>, joesmidt@byu.net,
       linux-kernel@vger.kernel.org
Subject: Re: Will there be Intel Wireless 3945ABG support?
References: <1152635563.4f13f77cjsmidt@byu.edu> <20060711171238.GA26186@tuxdriver.com> <200607111909.22972.s0348365@sms.ed.ac.uk>
In-Reply-To: <200607111909.22972.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alistair John Strachan wrote:
> On Tuesday 11 July 2006 18:12, John W. Linville wrote:
>> On Tue, Jul 11, 2006 at 10:32:43AM -0600, Joseph Michael Smidt wrote:
>>> Will 2.6.18 or 2.6.19 support Intel Wireless 3945ABG?  Please cc me since
>>> I am not subscribed.   Thanks.
>> It will not be in 2.6.18.  Making 2.6.19 is not out of the question,
>> but it may take some work.
> 
> Has some agreement been met regarding the mandatory use of the binary 
> regulatory daemon? The webpage seems to suggest it is still necessary, and 
> I'm sure that would disqualify merging the driver with Linux proper.
> 

Why not?
The whole point is running a system that you know you can support for many years,
even without a vendor support...
And to have a system that you know exactly what running in it...
Having a binary closed source violate this.

Also there is no good reason why supplying this daemon as closed source... All they
wish is people don't mess with their frequencies, and sooner or later someone will...

Best Regards,
Alon Bar-Lev.

