Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965075AbVI3SzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965075AbVI3SzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 14:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965076AbVI3SzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 14:55:21 -0400
Received: from wproxy.gmail.com ([64.233.184.197]:32310 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965075AbVI3SzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 14:55:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=se9b5rcfNtk1wBWJhDyCYRTrt+cGJGmI/P1WaWIT56TzCP6uco7JKc7OqYREWt9NhlHBfVWtnxKxVmKgLdlgEjpETA5lWzZShCl6kjT/UymYB8AOvhZLZLxhBQqp0qLC9S7wIxO04Y5Ky2ChoZ+k1Flc86oAoqnh3vHgvznsQ80=
Date: Fri, 30 Sep 2005 23:06:25 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel cross-toolchain (Gentoo)
Message-ID: <20050930190625.GA28762@mipter.zuzino.mipt.ru>
References: <20050905160313.GH5155@ZenIV.linux.org.uk> <20050905164712.GI5155@ZenIV.linux.org.uk> <20050905212026.GL5155@ZenIV.linux.org.uk> <20050907183131.GF5155@ZenIV.linux.org.uk> <20050912191744.GN25261@ZenIV.linux.org.uk> <20050912192049.GO25261@ZenIV.linux.org.uk> <20050930120831.GI7992@ftp.linux.org.uk> <20050930125645.GJ7992@ftp.linux.org.uk> <20050930160911.GA24810@mipter.zuzino.mipt.ru> <20050930160503.GK7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050930160503.GK7992@ftp.linux.org.uk>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2005 at 05:05:03PM +0100, Al Viro wrote:
> On Fri, Sep 30, 2005 at 08:09:11PM +0400, Alexey Dobriyan wrote:
> > 4) re m68k
> > 	binutils only. Haven't investigated.
> 
> Oh?  Both FC4 (4.0.1) and sarge (3.3.5) handle it without any complications

Duh... 3.3.6 for m68k builds just fine.

