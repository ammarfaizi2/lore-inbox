Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbTFDOuY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 10:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263354AbTFDOuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 10:50:24 -0400
Received: from ghostwheel.llnl.gov ([134.9.11.149]:45279 "EHLO
	ghostwheel.llnl.gov") by vger.kernel.org with ESMTP id S263349AbTFDOuX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 10:50:23 -0400
Date: Wed, 4 Jun 2003 08:03:36 -0700 (PDT)
From: Chuck Harding <charding@llnl.gov>
To: Linux Kernel Discussion List <linux-kernel@vger.kernel.org>
Subject: Re: Subject: Unresolved symbols from 'make modules_install'
In-Reply-To: <1982.1054704241@kao2.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.55.0306040800050.9083@ghostwheel.llnl.gov>
References: <1982.1054704241@kao2.melbourne.sgi.com>
Organization: Lawrence Livermore National Laboratory
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops - bad editing - as I said in the message that made it to the list, and I
quote:

I tried sending this yesterday but it didn't make it to the list, either
because of the number of lines or because of the size of the attachments B-|
If needed, I can send the full output from the depmod command.

On Wed, 4 Jun 2003, Keith Owens wrote:

> On Tue, 3 Jun 2003 10:27:05 -0700 (PDT),
> Chuck Harding <charding@llnl.gov> wrote:
> >with no errors, when I run the 'make modules_install' I get a bunch
> >of occurrances of unresolved symbol errors from 'depmod -ae -F System.map 2.x.x'
> >most of which are for what appear to be core functions that the
> >modules would need (output is attached
>
> You did not include any output from make modules_install.

it's 127k long - I don't think it works to send attachments that large to the
list.

>
> >as is my .config
>
> .config is from a 2.5 kernel, not 2.4.
>

That's because I was trying to build 2.5.70 as there are some of the new
features in it that I wanted to try out.

-- 
Charles D. (Chuck) Harding <charding@llnl.gov>  Voice: 925-423-8879
Senior Computer Associate                         Fax: 925-422-8920
Computation Directorate, Lawrence Livermore National Laboratory
Livermore, CA USA  http://www.llnl.gov  GPG Public Key ID: B9EB6601
