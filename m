Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268084AbUI1WQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268084AbUI1WQw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 18:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268079AbUI1WPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 18:15:45 -0400
Received: from smtp06.auna.com ([62.81.186.16]:50889 "EHLO smtp06.retemail.es")
	by vger.kernel.org with ESMTP id S268074AbUI1WNp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 18:13:45 -0400
Date: Tue, 28 Sep 2004 22:13:43 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: 2.6.9-rc2-mm4 e100 enable_irq unbalanced from
To: linux-kernel@vger.kernel.org
References: <1096313095.2601.20.camel@deimos.microgate.com>
	<1096326028l.5222l.0l@werewolf.able.es>
	<1096326541.5963.2.camel@at2.pipehead.org>
In-Reply-To: <1096326541.5963.2.camel@at2.pipehead.org> (from
	paulkf@microgate.com on Tue Sep 28 01:09:01 2004)
X-Mailer: Balsa 2.2.4
Message-Id: <1096409623l.9002l.2l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.09.28, Paul Fulghum wrote:
> On Mon, 2004-09-27 at 18:00, J.A. Magallon wrote:
> > Just a 'me-too', with a slightly different oops:
> 
> Can you try the following patch please?
> 

It has killed the messages, and I have not seen any side effects.
Network is working fine.

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc2-mm4 (gcc 3.4.1 (Mandrakelinux (Alpha 3.4.1-3mdk)) #2


