Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbUCGPth (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 10:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262169AbUCGPth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 10:49:37 -0500
Received: from mail.xor.at ([62.99.218.147]:20881 "EHLO merkur.xor.at")
	by vger.kernel.org with ESMTP id S262104AbUCGPtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 10:49:35 -0500
Message-ID: <404B4485.1050507@xor.at>
Date: Sun, 07 Mar 2004 16:49:25 +0100
From: Johannes Resch <jr@xor.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiple oopses with 2.4.25
References: <Pine.LNX.4.44.0403050914450.2678-100000@dmt.cyclades>
In-Reply-To: <Pine.LNX.4.44.0403050914450.2678-100000@dmt.cyclades>
X-Enigmail-Version: 0.83.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.16; AVE: 6.24.0.6; VDF: 6.24.0.42; host: mail.xor.at)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

On 2004-03-05 13:18, Marcelo Tosatti wrote:
> On Wed, 3 Mar 2004, Johnny Strom wrote:
>>
>>I also get multiple oopse's with 2.4.25 plus the latest
>>ipsec kernel patch form http://www.freeswan.org/.
>>
>>I have to reset the computer to get it working again,
>>below is the oopse's:
> 
> 
> Dear fellows,
> 
> I have seen similar reports. 
> 
> Can you find out which kernel does not exhibit the behaviour with the same
> freeswan/grsec patches ?


I'm not able to reproduce the oopses.
I've been running 2.4.24 / 2.4.23 with grsec 1.9.13 without any problems 
before.


--jr

