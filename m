Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbTJDQ1p (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 12:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbTJDQ1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 12:27:45 -0400
Received: from mail1.dac.neu.edu ([129.10.1.75]:38148 "EHLO mail1.dac.neu.edu")
	by vger.kernel.org with ESMTP id S262591AbTJDQ1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 12:27:43 -0400
Message-ID: <3F7EF4D6.2040306@ccs.neu.edu>
Date: Sat, 04 Oct 2003 12:27:02 -0400
From: Stan Bubrouski <stan@ccs.neu.edu>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5b) Gecko/20030917
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nigel Cunningham <ncunningham@clear.net.nz>
CC: Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [pm] fix oops after saving image
References: <20031002203906.GB7407@elf.ucw.cz> <Pine.LNX.4.44.0310031433530.28816-100000@cherise> <20031003223352.GB344@elf.ucw.cz> <3F7E57E9.8070904@ccs.neu.edu> <20031004080239.GA213@elf.ucw.cz> <1065253818.14870.27.camel@laptop-linux>
In-Reply-To: <1065253818.14870.27.camel@laptop-linux>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah that too :)

Nigel Cunningham wrote:

> I guess he means...
> 
> On Sat, 2003-10-04 at 20:02, Pavel Machek wrote:
> 
>>>>+ *    not freed; its not needed since system is going down anyway
> 
> 
> should be
> 
> 
>>>+ *    not freed; it's not needed since the system is going down anyway
> 
> 
> (it's = it is, its = belongs to it)
> 
> and
> 
> 
>>>>+ *    (plus it causes oops and I'm lazy^H^H^H^Htoo busy).
> 
> 
> should be
> 
> 
>>>+ *    (plus it causes an oops and I'm too lazy^H^H^H^Hbusy).
> 
> 
> Regards,
> 
> Nigel



