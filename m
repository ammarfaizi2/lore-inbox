Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267255AbSKSSwK>; Tue, 19 Nov 2002 13:52:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267273AbSKSSwJ>; Tue, 19 Nov 2002 13:52:09 -0500
Received: from magic.adaptec.com ([208.236.45.80]:30664 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP
	id <S267255AbSKSSwC>; Tue, 19 Nov 2002 13:52:02 -0500
Date: Tue, 19 Nov 2002 11:58:50 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Raptorfan <raptorfan@earthlink.net>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx driver failing (2.4.19-ac4)
Message-ID: <1604970000.1037732321@aslan.btc.adaptec.com>
In-Reply-To: <001b01c28ff8$61ad1670$420aa8c0@beast>
References: <001b01c28ff8$61ad1670$420aa8c0@beast>
X-Mailer: Mulberry/3.0.0a5 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Howdy. I'm having major fits with trying to use the aic7xxx driver with an
> Adaptec AHA2948UW.

Can you try to update your system with the driver version here:

http://people.freebsd.org/~gibbs/linux/tarballs/aic79xx-linux-2.4.tar.gz

The files are for the latest linux-2.4 tree, but should be easily
modified to work with the kernel you are using.

--
Justin
