Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272757AbTG1Irz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 04:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272758AbTG1Irz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 04:47:55 -0400
Received: from jive.SoftHome.net ([66.54.152.27]:52629 "HELO jive.SoftHome.net")
	by vger.kernel.org with SMTP id S272757AbTG1Ird (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 04:47:33 -0400
Message-ID: <3F24E6C6.9030802@softhome.net>
Date: Mon, 28 Jul 2003 11:03:02 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
Organization: Home Sweet Home
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miles Bader <miles@gnu.org>
CC: Hollis Blanchard <hollisb@us.ibm.com>, Otto Solares <solca@guug.org>,
       "J.A. Magallon" <jamagallon@able.es>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       David McCullough <davidm@snapgear.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6 size increase - get_current()?
References: <9CA735B0-BEAD-11D7-BEDE-000A95A0560C@us.ibm.com>	<buowue3l4ni.fsf@mcspd15.ucom.lsi.nec.co.jp>	<3F24DB59.1010600@softhome.net> <buosmorjadq.fsf@mcspd15.ucom.lsi.nec.co.jp>
In-Reply-To: <buosmorjadq.fsf@mcspd15.ucom.lsi.nec.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Bader wrote:
> "Ihar \"Philips\" Filipau" <filia@softhome.net> writes:
> 
>>   starting from -O3 gcc do always trys to do inlining.
>>   was observed on gcc 3.2 and I beleive I saw the same 2.95.3
>>
>>   compile this test with 02 & 03:
> 
> 
> Um, what's your point?
> 

   FYI only.
   no point at all.
   I meant that compiler - given a freedom to do so - can inline by itself.

