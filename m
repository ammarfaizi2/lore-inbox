Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261685AbVEUXCT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbVEUXCT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 19:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbVEUXCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 19:02:19 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:62090 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261685AbVEUXCL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 19:02:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=M6CdZpTG8Di3zvf5BoODU/w6UenR9atcpvpLCcDxz5Z3x2y3tsw7k9KDZDNmOVdYR416iyeyFkbeR6+4rRuEjjWqhKSO6XOeGmk8EBYxwgu4JAyLoNvVDP7ITEImdlBhjucAzuq7BWvZCWHgGY2vq4BmPKpASnPB/nt7mAHmLOI=
Message-ID: <8e6f947205052116025e7f2b88@mail.gmail.com>
Date: Sat, 21 May 2005 19:02:10 -0400
From: Will Dyson <will.dyson@gmail.com>
Reply-To: Will Dyson <will.dyson@gmail.com>
To: Robert Love <rml@novell.com>
Subject: Re: [patch] latest inotify.
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       John McCutchan <ttb@tentacle.dhs.org>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <1116271318.6589.66.camel@betsy>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1116271318.6589.66.camel@betsy>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/05, Robert Love <rml@novell.com> wrote:
> Attached is the latest inotify, against 2.6.12-rc4.

I'm using this with gamin 0.1.0 and nautilus 2.8.2. Seems to work
great (as expected). Thanks for all your hard work on this!
