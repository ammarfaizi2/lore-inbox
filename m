Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVCCVAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVCCVAp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 16:00:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbVCCVAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 16:00:40 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55468 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262413AbVCCU5x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:57:53 -0500
Message-ID: <42277A3D.9030805@pobox.com>
Date: Thu, 03 Mar 2005 15:57:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Chris Wright <chrisw@osdl.org>, Rene Rebe <rene@exactcode.de>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] trivial fix for 2.6.11 raid6 compilation on ppc w/ Altivec
References: <422751D9.2060603@exactcode.de> <422756DC.6000405@pobox.com> <20050303191840.GA12916@kroah.com> <42276A0C.9080505@pobox.com> <20050303200718.GR28536@shell0.pdx.osdl.net> <20050303203206.GB13522@kroah.com>
In-Reply-To: <20050303203206.GB13522@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Mar 03, 2005 at 12:07:18PM -0800, Chris Wright wrote:
>>Don't see why not, we were thinking of making it just an alias at
>>kernel.org.
> 
> 
> An alias would probably be easier, unless you think everything sent
> there should be archived?


I do.  But I don't have a strong opinion on the subject.

	Jeff


