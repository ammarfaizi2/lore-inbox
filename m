Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289766AbSAOXsr>; Tue, 15 Jan 2002 18:48:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289768AbSAOXsi>; Tue, 15 Jan 2002 18:48:38 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37138 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289766AbSAOXs1>; Tue, 15 Jan 2002 18:48:27 -0500
Message-ID: <3C44BFC0.3090709@zytor.com>
Date: Tue, 15 Jan 2002 15:48:16 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Andreas Dilger <adilger@turbolabs.com>, Alexander Viro <viro@math.psu.edu>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <Pine.GSO.4.21.0201131536480.27390-100000@weyl.math.psu.edu> <E16Qa0W-0001kH-00@starship.berlin> <20020115140436.L11251@lynx.adilger.int> <E16Qcha-0001lF-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

> 
> If we go with little-endian then only big-endian architectures will need
> the patch, and they tend to need patches for lots of things anyway.  Or
> if you like I'll write a little utility that goes through the file and
> byteswaps all the int fields.
> 


HUH?????????????????

	-hpa

