Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWJIUBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWJIUBz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 16:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWJIUBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 16:01:55 -0400
Received: from qb-out-0506.google.com ([72.14.204.238]:15811 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964800AbWJIUBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 16:01:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oUfjyySZSse3KhxaZWHVoIoHi6JA0mqdaDAUBQj4vzd12ki95CJvZVZRqkJcS4cD0CkxQsW/n0QqfpwL/vXuPxc49stT/QxRe2ENCaKp8RdP6CPSUPjvnFstj9WJHrbbXyVnJ9ILdLLL8d4rI43eCOxl+l+LTvrIsA9IhJd5860=
Message-ID: <6b4e42d10610091301v330a141fgd2eec7d21313de43@mail.gmail.com>
Date: Mon, 9 Oct 2006 13:01:52 -0700
From: "Om Narasimhan" <om.turyx@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: fixed PCMCIA au1000_generic.c potential crash.
Cc: "Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>, linux-kernel@vger.kernel.org,
       "Dominik Brodowski" <linux@dominikbrodowski.net>
In-Reply-To: <20061008135536.07b60db6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6b4e42d10610071626v22ca2dafpd88d689429313a98@mail.gmail.com>
	 <20061008135536.07b60db6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/06, Andrew Morton <akpm@osdl.org> wrote:
> On Sat, 7 Oct 2006 16:26:40 -0700
> "Om Narasimhan" <om.turyx@gmail.com> wrote:
>
> > Please find the corrected patch.
>
> The patch is wordwrapped, has spaces replaced by tabs and each version is
> subtly different from its predecessor.  This confuses me.
>
> Please confirm that the below is the appropriate and final patch, thanks.
Yes. it is.
Thanks
Om
