Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVEYCVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVEYCVi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 22:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262241AbVEYCVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 22:21:38 -0400
Received: from fire.osdl.org ([65.172.181.4]:21457 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261317AbVEYCVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 22:21:36 -0400
Date: Tue, 24 May 2005 19:20:29 -0700
From: Andrew Morton <akpm@osdl.org>
To: Sven Dietrich <sdietrich@mvista.com>
Cc: dwalker@mvista.com, bhuey@lnxw.com, nickpiggin@yahoo.com.au, mingo@elte.hu,
       hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-Id: <20050524192029.2ef75b89.akpm@osdl.org>
In-Reply-To: <4293DCB1.8030904@mvista.com>
References: <4292DFC3.3060108@yahoo.com.au>
	<20050524081517.GA22205@elte.hu>
	<4292E559.3080302@yahoo.com.au>
	<20050524090240.GA13129@elte.hu>
	<4292F074.7010104@yahoo.com.au>
	<1116957953.31174.37.camel@dhcp153.mvista.com>
	<20050524224157.GA17781@nietzsche.lynx.com>
	<1116978244.19926.41.camel@dhcp153.mvista.com>
	<20050525001019.GA18048@nietzsche.lynx.com>
	<1116981913.19926.58.camel@dhcp153.mvista.com>
	<20050525005942.GA24893@nietzsche.lynx.com>
	<1116982977.19926.63.camel@dhcp153.mvista.com>
	<20050524184351.47d1a147.akpm@osdl.org>
	<4293DCB1.8030904@mvista.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sven Dietrich <sdietrich@mvista.com> wrote:
>
> I think people would find their system responsiveness / tunability
>  goes up tremendously, if you drop just a few unimportant IRQs into
>  threads.

People cannot detect the difference between 1000usec and 50usec latencies,
so they aren't going to notice any changes in responsiveness at all.

