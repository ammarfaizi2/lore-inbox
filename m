Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269140AbUJQOTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269140AbUJQOTt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 10:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269142AbUJQOTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 10:19:48 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:60822 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269140AbUJQOTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 10:19:15 -0400
Message-ID: <41727F60.2000200@yahoo.com.au>
Date: Mon, 18 Oct 2004 00:19:12 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com>	<20041016171458.4511ad8b.akpm@osdl.org>	<4171C20D.1000105@pobox.com> <20041016182116.33b3b788.akpm@osdl.org> <4171E978.6060207@pobox.com> <41720740.2030901@yahoo.com.au> <417273F9.6050605@pobox.com> <41727866.3000009@yahoo.com.au> <41727AE9.9050703@pobox.com>
In-Reply-To: <41727AE9.9050703@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> _Someone_ just please get _something_ into 2.6.9-final, so that the 
> kernel doesn't hang under heavy I/O (someone else ack'd the problem, and 
> the fix, privately as well, under a totally different test case).
> 

Yep. Andrew was of course the one who sent my fix to Linus. Please
make sure you get that someone else to test the next -bk release too :)
