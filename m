Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266438AbRGJObD>; Tue, 10 Jul 2001 10:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbRGJOaw>; Tue, 10 Jul 2001 10:30:52 -0400
Received: from weta.f00f.org ([203.167.249.89]:42114 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266422AbRGJOaq>;
	Tue, 10 Jul 2001 10:30:46 -0400
Date: Wed, 11 Jul 2001 02:30:39 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Jesper Juhl <juhl@eisenstein.dk>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: How many pentium-3 processors does SMP support?
Message-ID: <20010711023039.D31966@weta.f00f.org>
In-Reply-To: <Pine.GSO.4.21.0107092315140.493-100000@faith.cs.utah.edu> <9ie450$d1p$1@cesium.transmeta.com> <20010711015128.E31799@weta.f00f.org> <3B4B28F8.49A6934A@eisenstein.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B4B28F8.49A6934A@eisenstein.dk>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 04:10:32PM +0000, Jesper Juhl wrote:

    There are some machines (like the Compaq Proliant ML770 -
    http://www.compaq.com/products/quickspecs/10698_div/10698_div.html)
    that are actually sold as 32 way systems based on Pentium III Xeon
    CPU's, so why not let the cpu array be able to handle that many
    CPU's by default (maybe make a config option?)?

Wow... what a beats.  Its CMP based which isn't supported.  I wonder
if more details on that are available somewhere?



  --cw
