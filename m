Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932355AbWITT5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932355AbWITT5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932354AbWITT5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:57:42 -0400
Received: from www.osadl.org ([213.239.205.134]:5836 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S932353AbWITT5k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:57:40 -0400
Subject: Re: 2.6.18-rt1
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       John Stultz <johnstul@us.ibm.com>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <45118EEC.2080700@cybsft.com>
References: <20060920141907.GA30765@elte.hu>  <45118EEC.2080700@cybsft.com>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 21:58:52 +0200
Message-Id: <1158782332.5724.1026.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-20 at 13:56 -0500, K.R. Foley wrote:
> EIP:    0060:[<c0130ad4>]    Not tainted VLI
> EFLAGS: 00010297   (2.6.17-rt8 #4)

----------------------^^^^^^^^^^^^^

Are you sure, that kernel and .config are related ?

	tglx


