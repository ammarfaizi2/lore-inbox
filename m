Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261818AbTI3Xyr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 19:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261809AbTI3Xw1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 19:52:27 -0400
Received: from panda.sul.com.br ([200.219.150.4]:18436 "EHLO panda.sul.com.br")
	by vger.kernel.org with ESMTP id S261797AbTI3XwM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 19:52:12 -0400
Date: Wed, 1 Oct 2003 20:51:44 -0300
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: keyboard repeat / sound [was Re: Linux 2.6.0-test6]
Message-ID: <20031001235144.GB1318@cathedrallabs.org>
References: <Pine.LNX.4.44.0309271822450.6141-100000@home.osdl.org> <20030928085902.GA3742@k3.hellgate.ch> <20030929151643.GA15992@ucw.cz> <20030930075024.GA1620@squish.home.loc> <20030930125126.GA24122@ucw.cz> <20030930132134.GA17242@cathedrallabs.org> <20030930134453.GA25198@ucw.cz> <20030930140521.GB17242@cathedrallabs.org> <20030930141651.GB25492@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030930141651.GB25492@ucw.cz>
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ahh, I think I remember. Well, you can still try with atkbd_softrepeat=1
> to see if the too fast autorepeat still happens if software autorepeat
> is used. It doesn't work with test6, but test7 will hopefully include a
> fix.
it's already fixed in test6 :)

thanks,

-- 
aris

