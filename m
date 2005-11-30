Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbVK3C03@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbVK3C03 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 21:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750797AbVK3C03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 21:26:29 -0500
Received: from zproxy.gmail.com ([64.233.162.207]:23822 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750792AbVK3C03 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 21:26:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CKUI6DfVE7luDXkEU6XSnSB+u5IHY4M+5gUJ5l69wdRlnTuGmkRWTzfdfwxYpIYIF849fl4GEIXqL94/0DlJSRZD+OdDvEX+/mzG0WYOmqV4k7Fm8L08GkvmGtqxOnXsGYwviQwsVU3ixQvXjeaH49FS+1ki9bxo/bPBDyS0hVs=
Message-ID: <a762e240511291826l7c91d836i1b6c750a49ed576d@mail.gmail.com>
Date: Tue, 29 Nov 2005 18:26:28 -0800
From: Keith Mannthey <kmannth@gmail.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: x86-64 2.6.15-rc2-git5 fails to boot with 4GB memory
Cc: Matti Aarnio <matti.aarnio@zmailer.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051130003118.GZ19515@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051129033102.GA5706@mea-ext.zmailer.org>
	 <p73veybh7tj.fsf@verdi.suse.de>
	 <20051129235304.GB5706@mea-ext.zmailer.org>
	 <20051130003118.GZ19515@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/05, Andi Kleen <ak@suse.de> wrote:
> > Not that those explain all that much...
>
> Can you send me your .config? If you have SPARSEMEM enabled can you
 > disable it?

This looks just like the sparsemem troubles.  There is a patch around
somwhere....  I thought a patch was being pushed into mainline but I
guess not.

Thanks,
 Keith
