Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262345AbVCIMj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262345AbVCIMj3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 07:39:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262346AbVCIMj3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 07:39:29 -0500
Received: from hellhawk.shadowen.org ([80.68.90.175]:50180 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S262345AbVCIMjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 07:39:19 -0500
Message-ID: <422EEE59.8000206@shadowen.org>
Date: Wed, 09 Mar 2005 12:38:49 +0000
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org, chrisw@osdl.org, torvalds@osdl.org,
       akpm@osdl.org
Subject: Re: Linux 2.6.11.2
References: <20050309083923.GA20461@kroah.com>
In-Reply-To: <20050309083923.GA20461@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> which is a patch against the 2.6.11.1 release.  If consensus arrives
> that this patch should be against the 2.6.11 tree, it will be done that
> way in the future.

It seems to me that we have V (delta?) and VI (delta incremental) for 
all the other kernel patch series.  So perhaps we could have both, the V 
being from 2.6.11 and the VI from 2.6.11.1.

-apw
