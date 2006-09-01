Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932393AbWIARFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932393AbWIARFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 13:05:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWIARFV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 13:05:21 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:19163 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932393AbWIARFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 13:05:20 -0400
Subject: Re: [patch 3/9] Guest page hinting: volatile page cache.
From: Dave Hansen <haveblue@us.ibm.com>
To: schwidefsky@de.ibm.com
Cc: Andy Whitcroft <apw@shadowen.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, akpm@osdl.org, nickpiggin@yahoo.com.au,
       frankeh@watson.ibm.com
In-Reply-To: <1157130150.21733.70.camel@localhost>
References: <20060901110948.GD15684@skybase>
	 <1157122667.28577.69.camel@localhost.localdomain>
	 <1157124674.21733.13.camel@localhost>  <44F8563B.3050505@shadowen.org>
	 <1157126640.21733.43.camel@localhost>
	 <1157128157.28577.129.camel@localhost.localdomain>
	 <1157130150.21733.70.camel@localhost>
Content-Type: text/plain
Date: Fri, 01 Sep 2006 10:05:05 -0700
Message-Id: <1157130306.28577.143.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-01 at 19:02 +0200, Martin Schwidefsky wrote:
> Yes, that would be really useful for the writable ptes. But I have the
> feeling that the actual implementation of it will be tricky. 

I'm confident that anyone able to produce nine patches like what I just
saw is capable of producing at least one more tricky one. ;)

-- Dave

