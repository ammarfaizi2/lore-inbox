Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbWBWRmY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbWBWRmY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:42:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWBWRmY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:42:24 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:40678 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S932330AbWBWRmY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:42:24 -0500
From: Francesco Biscani <biscani@pd.astro.it>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: libata PATA drivers patch for 2.6.16-rc4
Date: Thu, 23 Feb 2006 18:42:01 +0100
User-Agent: KMail/1.9.1
Cc: Ed Sweetman <safemode@comcast.net>, linux-kernel@vger.kernel.org
References: <1140445182.26526.1.camel@localhost.localdomain> <43FD347B.6030802@comcast.net> <1140707265.4332.6.camel@localhost.localdomain>
In-Reply-To: <1140707265.4332.6.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200602231842.02176.biscani@pd.astro.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 23 February 2006 16:07, Alan Cox wrote:
> Thanks for all the reports on the oops on boot. I was able to duplicate
> it and fix the dumb bug that caused it.
>
> New patch (2.6.16-rc4-ide2)
>
> 	http://zeniv.linux.org.uk/~alan/IDE

Hello Alan,

the latest patch has not solved the performance problems on my laptop's Ali 
chipset. Just to let you know....

Thanks,

  Francesco

-- 
Dr. Francesco Biscani
Dipartimento di Astronomia
Università di Padova
biscani@pd.astro.it
