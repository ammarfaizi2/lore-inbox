Return-Path: <linux-kernel-owner+w=401wt.eu-S932142AbXAOJWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbXAOJWO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 04:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbXAOJWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 04:22:14 -0500
Received: from sd291.sivit.org ([194.146.225.122]:2741 "EHLO sd291.sivit.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932142AbXAOJWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 04:22:13 -0500
Subject: Re: [PATCH] Fix __ucmpdi2 in v4l2_norm_to_name()
From: Stelian Pop <stelian@popies.net>
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, v4l-dvb-maintainer@linuxtv.org
In-Reply-To: <1168170280.27419.69.camel@praia>
References: <1167909014.20853.8.camel@localhost.localdomain>
	 <20070104144825.68fec948.akpm@osdl.org> <1167951548.12012.55.camel@praia>
	 <20070104151837.1a878a20.akpm@osdl.org>  <1168170280.27419.69.camel@praia>
Content-Type: text/plain; charset=ISO-8859-15
Date: Mon, 15 Jan 2007 10:22:09 +0100
Message-Id: <1168852929.6624.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 07 janvier 2007 à 09:44 -0200, Mauro Carvalho Chehab a
écrit :

> > > We can, however use this approach as a workaround, with
> > > the proper documentation. I'll handle it after I return from vacations
> > > next week.
> Ok, I've wrote such patch. I should send today or tomorrow to Linus,
> together with other patches.

Hi Mauro,

The __ucmpdi2() problem is still present in 2.6.20-rc5, please (re)send
your patch to Linus before 2.6.20 goes final...

Thanks.

-- 
Stelian Pop <stelian@popies.net>

