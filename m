Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbVLNVRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbVLNVRc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 16:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVLNVRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 16:17:31 -0500
Received: from [212.76.84.161] ([212.76.84.161]:15628 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S932335AbVLNVRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 16:17:31 -0500
From: Al Boldi <a1426z@gawab.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Linux in a binary world... a doomsday scenario
Date: Thu, 15 Dec 2005 00:13:29 +0300
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200512150013.29549.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> For people to think that the kernel developers are just "too dumb" to 
> make a stable kernel api (and yes, I've had people accuse me of this 
> many times to my face[1]) shows a total lack of understanding as to 
> _why_ we change the in-kernel api all the time.  Please see
> Documentation/stable_api_nonsense.txt for details on this. 

I read this doc, and it doesn't make your case any clearer, on the contrary!

But first, your work to the kernel represents a not so dumb contribution, 
especially the replacement of devfs.  Thanks!

Now, to call a stable api nonsense is nonsense.  Really, only a _stable_ api 
is worth to be considered an API.  Think about it.

The only advantage of not offering a _stable_ api is to enforce some weird 
kind of copy protection scheme, because let's face it:

An API would benefit everybody, even those that may take advantage of it.

So to limit the kernel by making it awkward to interact with it, because 
somebody may take advantage, is a rather paranoid way of doing things.

Things are bad enough the kernel being monolithic, and then inhibiting a sane 
API to develop may only serve to delay the competitiveness of the kernel.

Loose the paranoia and prove GNU/Linux can stand on its own.

Thanks!

--
Al

