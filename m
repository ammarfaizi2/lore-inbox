Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbUJaUWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbUJaUWL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 15:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUJaUWL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 15:22:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51872 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261651AbUJaUWI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 15:22:08 -0500
Message-ID: <4185495E.1060206@pobox.com>
Date: Sun, 31 Oct 2004 15:21:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Theodore Ts'o" <tytso@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel> <200410310000.38019.vda@port.imtp.ilyichevsk.odessa.ua> <1099170891.1424.1.camel@krustophenia.net> <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua> <20041030222720.GA22753@hockin.org> <4184193A.3060406@pobox.com> <20041031201500.GA4498@thunk.org>
In-Reply-To: <20041031201500.GA4498@thunk.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> On Sat, Oct 30, 2004 at 06:44:10PM -0400, Jeff Garzik wrote:
> 
>>Tim Hockin wrote:
>>
>>>So you end up with the mindset of, for example, "if it's text it's XML".
>>>You have to parse everything as XML, when simple parsers would be tons
>>>faster and simpler and smaller.
>>
>>hehehe.  One of the reasons why I like XML is that you don't have to 
>>keep cloning new parsers.
> 
> 
> .... if you don't mind bloating your application:
> 
> % ls -l /usr/lib/libxml2.a
> 4224 -rw-r--r--  1 root root 4312536 Oct 19 21:55 /usr/lib/libxml2.a

GLib's is a lot smaller :)

	Jeff



