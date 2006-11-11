Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424025AbWKKQKi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424025AbWKKQKi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 11:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424255AbWKKQKi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 11:10:38 -0500
Received: from smtp121.iad.emailsrvr.com ([207.97.245.121]:65421 "EHLO
	smtp121.iad.emailsrvr.com") by vger.kernel.org with ESMTP
	id S1424025AbWKKQKi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 11:10:38 -0500
Message-ID: <4555D814.1000608@gentoo.org>
Date: Sat, 11 Nov 2006 09:03:00 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060917)
MIME-Version: 1.0
To: Jeff Garzik <jeff@garzik.org>
CC: "Michael D. Setzer II" <mikes@kuentos.guam.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Failure of sata_via with kernels since 2.6.15.6
References: <455501B3.13819.421AEC9@mikes.kuentos.guam.net> <455485FC.1040607@garzik.org>
In-Reply-To: <455485FC.1040607@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Can you try 2.6.19-rc5-git2?
> 
> There were very recent sata_via fixes pushed upstream.

And if that doesn't work, drop this patch in on top:
http://marc.theaimsgroup.com/?l=linux-kernel&m=116300291505638&q=raw

Daniel

