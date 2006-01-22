Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWAVTzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWAVTzl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 14:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWAVTzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 14:55:41 -0500
Received: from xproxy.gmail.com ([66.249.82.192]:62658 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751305AbWAVTzk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 14:55:40 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LiTZCXJ79d6N8v+/eW4OczGpKWzRgL0OtBH9m6Bt4Tkmpp2O+IDJw1RQykj+zUDm3v6LfXMotvMH2Iqd98QTyuof8qYgCWmvvUqUsoO75a8htBJQDvSR9au+0pCd9dSsK8luNyilqMK8gVXk+enr+jmCmLIWjhcNfGF1/Nu20Qc=
Message-ID: <986ed62e0601221155x6a57e353vf14db02cc219c09@mail.gmail.com>
Date: Sun, 22 Jan 2006 11:55:37 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Al Boldi <a1426z@gawab.com>
Subject: Re: [RFC] VM: I have a dream...
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <200601212108.41269.a1426z@gawab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200601212108.41269.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/06, Al Boldi <a1426z@gawab.com> wrote:
> A long time ago, when i was a kid, I had dream. It went like this:
[snip]

FWIW, Mac OS X is one step closer to your vision than the typical
Linux distribution: It has a directory for swapfiles -- /var/vm -- and
it creates new swapfiles there as needed. (It used to be that each
swapfile would be 80MB, but the iMac next to me just has a single 64MB
swapfile, so maybe Mac OS 10.4 does something different now.)
