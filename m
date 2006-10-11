Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161357AbWJKT0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161357AbWJKT0r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 15:26:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161359AbWJKT0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 15:26:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:4483 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161357AbWJKT0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 15:26:46 -0400
Subject: Re: [RFC] Avoid PIT SMP lockups
From: john stultz <johnstul@us.ibm.com>
To: caglar@pardus.org.tr
Cc: kraxel@suse.de, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200610112209.23037.caglar@pardus.org.tr>
References: <1160170736.6140.31.camel@localhost.localdomain>
	 <200610112137.01160.caglar@pardus.org.tr>
	 <1160592235.5973.5.camel@localhost.localdomain>
	 <200610112209.23037.caglar@pardus.org.tr>
Content-Type: text/plain; charset=utf-8
Date: Wed, 11 Oct 2006 12:26:42 -0700
Message-Id: <1160594802.5973.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-11 at 22:09 +0300, S.Çağlar Onur wrote:
> 11 Eki 2006 Çar 21:43 tarihinde, john stultz şunları yazmıştı: 
> > S.Çağlar: Didn't follow this bit at all. Could you explain a bit more?
> 
> Of course, while system boots kernel waits ~5 seconds (maybe more) after 
> printing "Checking if this processor honours the WP bit even in supervisor 
> mode... Ok." line without any visual activity and after that waiting period 
> kernel panics.

And this results in the same panic you linked to earlier?

thanks
-john


