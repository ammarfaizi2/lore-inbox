Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276211AbRJCNYT>; Wed, 3 Oct 2001 09:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276223AbRJCNYL>; Wed, 3 Oct 2001 09:24:11 -0400
Received: from janeway.cistron.net ([195.64.65.23]:52740 "EHLO
	janeway.cistron.net") by vger.kernel.org with ESMTP
	id <S276211AbRJCNYA>; Wed, 3 Oct 2001 09:24:00 -0400
Date: Wed, 3 Oct 2001 15:24:26 +0200
From: Wichert Akkerman <wichert@cistron.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-lvm@sistina.com
Subject: Re: [linux-lvm] Re: partition table read incorrectly
Message-ID: <20011003152426.B31796@cistron.nl>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-lvm@sistina.com
In-Reply-To: <20011002202934.G14582@wiggy.net> <E15oUUf-0005Xw-00@the-village.bc.nu> <20011002220053.H14582@wiggy.net> <20011002150820.N8954@turbolinux.com> <20011003142633.A16089@cistron.nl> <20011003144236.A31796@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011003144236.A31796@cistron.nl>; from wichert@cistron.nl on Wed, Oct 03, 2001 at 02:42:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Other data point: the 2.2.19 kernel as found on the lnx bootable business
card also gets it wrong and detect a sdb1..

Wichert.

-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |
