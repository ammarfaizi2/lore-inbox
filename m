Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269281AbUJQTxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269281AbUJQTxk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 15:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269272AbUJQTxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 15:53:40 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:43527 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269281AbUJQTxe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 15:53:34 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Simon Kissane <skissane@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Running user processes in kernel mode; Java and .NET support in kernel
Date: Sun, 17 Oct 2004 22:53:28 +0300
User-Agent: KMail/1.5.4
References: <82fa66380410152111143f75ec@mail.gmail.com> <82fa6638041016055934097b80@mail.gmail.com>
In-Reply-To: <82fa6638041016055934097b80@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410172253.28215.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 16 October 2004 15:59, Simon Kissane wrote:
> Hi
> 
> Having posted the below to this list, Denis Vlasenko pointed out to me
> (in an email) that I should have said "user<->kernel" switch, not
> context switch. Yep, my mistake. He argues that is not that big. Of
> course its no where near as big as a context switch. But its still
> something.
> 
> Also, I found a website by someone who had this idea before me (and
> unlike me, actually implemented it!).
> "Kernel Mode Linux" by Toshiyuki Maeda
> http://web.yl.is.s.u-tokyo.ac.jp/~tosh/kml/
> Main difference is, that rather thinking in terms of Java or Mono
> support, he is thinking in terms of another system he calls "Typed
> Assembly Language". Same basic idea though...

Nice page. Doubly nice considering that they have working code.

However, it does not mention how much of a speedup they achieved.
--
vda

