Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbUCHOh3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 09:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262495AbUCHOh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 09:37:29 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:24520 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S262493AbUCHOh1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 09:37:27 -0500
Message-ID: <404C851E.50902@stesmi.com>
Date: Mon, 08 Mar 2004 15:37:18 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7a) Gecko/20040219
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Morris <jmorris@redhat.com>
CC: Max Valdez <maxvalde@fis.unam.mx>, linux-kernel@vger.kernel.org
Subject: Re: distcc crashes fedora 2.4.22-1.2149.nptl
References: <Xine.LNX.4.44.0403080928240.22156-100000@thoron.boston.redhat.com>
In-Reply-To: <Xine.LNX.4.44.0403080928240.22156-100000@thoron.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris wrote:

> On Sun, 7 Mar 2004, Max Valdez wrote:
> 
> 
>>I know this is not the correct list to ask problems about fedora, but maybe 
>>someone knows what can be happening, and what can I do to trace the problem 
>>down. Should I try to install a vanilla kernel to see if that corrects the 
>>problem ?
> 
> 
> One of the fedora mailing lists would be a better place to post.
> 
> Do you have SELinux enabled?

Just a note : kernel 2.4.22-1.2149.nptl is one of the update kernels for
Fedora Core 1, and SELlinux wasn't included in FC1.

> Try and get a log of the kernel oops via serial console, or at least write 
> down the traceback functions.

// Stefan
