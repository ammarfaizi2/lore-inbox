Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbUJ3WoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbUJ3WoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 18:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUJ3WoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 18:44:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27576 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261373AbUJ3WoY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 18:44:24 -0400
Message-ID: <4184193A.3060406@pobox.com>
Date: Sat, 30 Oct 2004 18:44:10 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Hockin <thockin@hockin.org>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Lee Revell <rlrevell@joe-job.com>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua> <1099170891.1424.1.camel@krustophenia.net> <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua> <20041030222720.GA22753@hockin.org>
In-Reply-To: <20041030222720.GA22753@hockin.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Hockin wrote:
> So you end up with the mindset of, for example, "if it's text it's XML".
> You have to parse everything as XML, when simple parsers would be tons
> faster and simpler and smaller.


hehehe.  One of the reasons why I like XML is that you don't have to 
keep cloning new parsers.

	Jeff


