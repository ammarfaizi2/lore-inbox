Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWCLQbz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWCLQbz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 11:31:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751507AbWCLQbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 11:31:55 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:28463 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750946AbWCLQby convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 11:31:54 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ifylOFUQBZzfwZVvc3uA/+BXlOaFHHsXm8e8zt/YW2RiVSMHWl8ijhbeW71f93BiKCibHymZRxFoeiylxaxJWEX3c8Y4spXxH+Rsh4PumegWvwXK3gI6r0cWPXSpSmKuCeOt6u43XICDz6BruX8srDskPxMMmKEphy2sx1yNcSg=
Message-ID: <b6c5339f0603120831o56ca4b9erf721c573ad7e173d@mail.gmail.com>
Date: Sun, 12 Mar 2006 11:31:49 -0500
From: "Bob Copeland" <bcopeland@gmail.com>
To: "Greg KH" <greg@kroah.com>
Subject: Re: 2.6.16-rc5 pppd oops on disconnects
Cc: linux-usb-devel@lists.sourceforge.net, paulus@samba.org,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060312053532.GA23307@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <b6c5339f0603100625k3410897fy3515d93fa1918c9@mail.gmail.com>
	 <20060312053532.GA23307@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/12/06, Greg KH <greg@kroah.com> wrote:
> There is an open Novell bug for this issue, but the USB developers that
> have tried to fix this in the past have had no luck at all (probably
> because we don't have the device to test with).
>
> What exact model of phone is this?

It's a Nokia 6230.  I'm happy to test patches, and I'll also take a
glance at the code when I get some time to see what I can figure out.

-Bob
