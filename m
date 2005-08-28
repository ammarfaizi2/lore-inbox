Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750761AbVH1ToD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbVH1ToD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 15:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750772AbVH1ToD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 15:44:03 -0400
Received: from xproxy.gmail.com ([66.249.82.201]:49934 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750762AbVH1ToB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 15:44:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VkboVDGzZc6LKZXSclMEdGMNldEM0lPnqBhaQdXFXVtCAt/FZS/jM3Vmys8xJ6Wf5rwyHaUFREhRlmu7cid6MAWIxsAaf6xHQHrcvMFNM6WlA7MDmG94qUfe9dQI8FtOwa+2N1s3SZBEQTrew6XgChqY9hcEVmnhDJQFNq+V6g0=
Message-ID: <c295378405082812434429ccd1@mail.gmail.com>
Date: Sun, 28 Aug 2005 12:43:54 -0700
From: "Jason R. Martin" <nsxfreddy@gmail.com>
To: iSteve <isteve@rulez.cz>
Subject: Re: Possibly wrong contact for e100 driver
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <43120783.7040406@rulez.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43120783.7040406@rulez.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/28/05, iSteve <isteve@rulez.cz> wrote:
> Greetings,
> in past few days, I've been trying to obtain certian information about
> behavior of e100 NIC driver with my minipci card. My first hit was the
> contact information mentioned in the header of e100.c, that is, "Linux
> NICS <linux.nics@intel.com>".
> 
> I've sent in my mail, praying for reply. The first reply was automated
> response, which suggested me eg. Win 3.11 install notes. After asking
> tech support reply, the email from tech support, which arrived day
> later, only told me that Intel doesn't distribute MiniPCI cards
> directly, instead sells them to companies who distribute them. He also
> suggested me to "for the best possible technical support and the latest
> drivers for your MPCI hardware, please contact the manufacturer of your
> PC".
> 
> Since I sent a rather technical question, and got such reply (and no
> reply so far, when I asked for better support - contact on someone
> closer to the actual driver, be it from Intel or not, politely), I
> wonder whether the contact information is still up to date? If no, what
> is the new contact information?

Try asking on netdev@vger.kernel.org.  Or email the guys listed in
MAINTAINERS for e100.  Or check out the e1000 sourceforge project
(which covers e100 and ixgb as well).

Jason
