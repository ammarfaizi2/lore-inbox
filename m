Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266633AbUHQThh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUHQThh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 15:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266635AbUHQThh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 15:37:37 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:13514 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S266633AbUHQThg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 15:37:36 -0400
Message-ID: <2a4f155d040817123712570ca0@mail.gmail.com>
Date: Tue, 17 Aug 2004 22:37:34 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Paul Fulghum <paulkf@microgate.com>
Subject: Re: 2.6.8.1-mm1 Tty problems?
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41225D16.2050702@microgate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <2a4f155d040817070854931025@mail.gmail.com> <412247FF.5040301@microgate.com> <2a4f155d0408171116688a87f1@mail.gmail.com> <4122501B.7000106@microgate.com> <2a4f155d04081712005fdcdd9b@mail.gmail.com> <41225D16.2050702@microgate.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004 14:31:34 -0500, Paul Fulghum <paulkf@microgate.com> wrote:
> 
> Try recreating /dev/tty as a char special file:
> mknod -m 666 /dev/tty c 5 0
> 

Yes totally works! 

Cheers,
ismail

-- 
Time is what you make of
