Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269792AbUICTuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269792AbUICTuC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 15:50:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269779AbUICTsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 15:48:43 -0400
Received: from wasp.net.au ([203.190.192.17]:55459 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S269793AbUICTow (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 15:44:52 -0400
Message-ID: <4138C9DA.6040100@wasp.net.au>
Date: Fri, 03 Sep 2004 23:45:30 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 0.7+ (X11/20040730)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg Stark <gsstark@mit.edu>
CC: Eric Mudama <edmudama@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: Crashed Drive, libata wedges when trying to recover data
References: <87oekpvzot.fsf@stark.xeocode.com> <4136E277.6000408@wasp.net.au>	<87u0ugt0ml.fsf@stark.xeocode.com>	<1094209696.7533.24.camel@localhost.localdomain>	<87d613tol4.fsf@stark.xeocode.com>	<1094219609.7923.0.camel@localhost.localdomain>	<877jrbtkds.fsf@stark.xeocode.com>	<1094224166.8102.7.camel@localhost.localdomain>	<871xhjti4b.fsf@stark.xeocode.com>	<311601c904090310083d057c25@mail.gmail.com> <87k6vbs0a9.fsf@stark.xeocode.com>
In-Reply-To: <87k6vbs0a9.fsf@stark.xeocode.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Stark wrote:

> I read somewhere that the current generation of SATA drives from everyone
> except Seagate were really PATA with a "bridge". It sounded like BS to me, but
> is that why they're behaving like PATA drives as far as these error codes? Or
> is it simply a question of the shared firmware codebase?
> 

Turn your Maxtor over and have a look. There is the bridge chip sitting on the bottom of the board.

