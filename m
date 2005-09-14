Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030264AbVINQit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbVINQit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbVINQit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:38:49 -0400
Received: from paleosilicon.orionmulti.com ([209.128.68.66]:31454 "EHLO
	paleosilicon.orionmulti.com") by vger.kernel.org with ESMTP
	id S1030264AbVINQit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:38:49 -0400
X-Envelope-From: hpa@zytor.com
Message-ID: <43285204.6000504@zytor.com>
Date: Wed, 14 Sep 2005 09:38:28 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pascal.bellard@ads-lu.com
CC: Frank Sorenson <frank@tuxrocks.com>, riley@williams.name,
       linux-kernel@vger.kernel.org
Subject: Re: [i386 BOOT CODE] kernel bootable again
References: <33542.85.68.36.53.1126619176.squirrel@212.11.36.192>    <432722A1.8030302@tuxrocks.com> <43272B9D.1030301@zytor.com> <33296.85.68.36.53.1126690932.squirrel@212.11.36.192>
In-Reply-To: <33296.85.68.36.53.1126690932.squirrel@212.11.36.192>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal Bellard wrote:
> 
> Now two solutions:
> 
> - without this patch = linux kernel are never directly bootable
> - with this patch = linux kernel is directly bootable with some
>   devices.
> 
> What is the better idea ?
> 

The former, based on the *huge* number of emails of "it doesn't work on 
my platform" we kept getting, and getting, and getting.

It would be another matter if it was a high-value feature, but it's not.

	-hpa
