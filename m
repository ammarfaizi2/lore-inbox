Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278927AbRKXRol>; Sat, 24 Nov 2001 12:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279064AbRKXRob>; Sat, 24 Nov 2001 12:44:31 -0500
Received: from pc-62-30-67-59-az.blueyonder.co.uk ([62.30.67.59]:23790 "EHLO
	kushida.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S278927AbRKXRoQ>; Sat, 24 Nov 2001 12:44:16 -0500
Date: Sat, 24 Nov 2001 17:26:24 +0000
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org
Subject: Re: Moving ext3 journal file
Message-ID: <20011124172624.A13504@kushida.jlokier.co.uk>
In-Reply-To: <E167Fuw-00001K-00@DervishD> <20011123155901.C1308@lynx.no> <9tmocg$jfn$1@cesium.transmeta.com> <20011123174120.Q1308@lynx.no> <9tmr83$jo2$1@cesium.transmeta.com> <20011123212557.U1308@lynx.no> <3BFF2AAE.7000000@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BFF2AAE.7000000@zytor.com>; from hpa@zytor.com on Fri, Nov 23, 2001 at 09:05:50PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> >  Sadly, neither cpio or tar
> > know about ext2 attributes.

Indeed, I once accidentally copied a .journal file from one filesystem
to another.  Not helpful.

-- Jamie
