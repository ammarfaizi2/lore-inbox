Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbWITUjx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbWITUjx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 16:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751046AbWITUjx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 16:39:53 -0400
Received: from www.osadl.org ([213.239.205.134]:43468 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751037AbWITUjw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 16:39:52 -0400
Subject: Re: 2.6.18-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <4511A57D.9070500@cybsft.com>
References: <20060920141907.GA30765@elte.hu> <45118EEC.2080700@cybsft.com>
	 <20060920194958.GA24691@elte.hu>  <4511A57D.9070500@cybsft.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 22:41:03 +0200
Message-Id: <1158784863.5724.1027.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 15:33 -0500, K.R. Foley wrote:
> DOH! The log had two different boots in it. :( Let's try this again. By
> the way, you may notice from my screw up that this is pretty much the
> same oops that I got with 2.6.17-rt*. I have been getting this on all of
> my SMP systems since we went past 2.6.16.

Which module is modprobed ?

	tglx


