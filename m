Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277024AbRJCXjj>; Wed, 3 Oct 2001 19:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277025AbRJCXja>; Wed, 3 Oct 2001 19:39:30 -0400
Received: from janeway.cistron.net ([195.64.65.23]:44548 "EHLO
	janeway.cistron.net") by vger.kernel.org with ESMTP
	id <S277024AbRJCXjX>; Wed, 3 Oct 2001 19:39:23 -0400
Date: Thu, 4 Oct 2001 01:39:50 +0200
From: Wichert Akkerman <wichert@cistron.nl>
To: linux-lvm@sistina.com
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] Re: partition table read incorrectly
Message-ID: <20011004013950.A16757@cistron.nl>
Mail-Followup-To: linux-lvm@sistina.com, alan@lxorguk.ukuu.org.uk,
	linux-kernel@vger.kernel.org
In-Reply-To: <200110031901.TAA04080@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200110031901.TAA04080@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Wed, Oct 03, 2001 at 07:01:10PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Andries.Brouwer@cwi.nl wrote:
> But why do you call it wrong?

I deleted all partitions with fdisk so I expect none to be there.
fdisk shows none, but the kernel does.

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
