Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281192AbRKYW4M>; Sun, 25 Nov 2001 17:56:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281188AbRKYWzw>; Sun, 25 Nov 2001 17:55:52 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:15607
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281192AbRKYWzo>; Sun, 25 Nov 2001 17:55:44 -0500
Date: Sun, 25 Nov 2001 14:55:37 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mike Castle <dalgoda@ix.netcom.com>, linux-kernel@vger.kernel.org,
        Michael Zimmermann <zim@vegaa.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: Moving ext3 journal file
Message-ID: <20011125145537.C30336@mikef-linux.matchmail.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org, Michael Zimmermann <zim@vegaa.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andreas Dilger <adilger@turbolabs.com>
In-Reply-To: <E167Fuw-00001K-00@DervishD> <20011123155901.C1308@lynx.no> <9tmocg$jfn$1@cesium.transmeta.com> <20011123174120.Q1308@lynx.no> <9tmr83$jo2$1@cesium.transmeta.com> <20011123212557.U1308@lynx.no> <3BFF2AAE.7000000@zytor.com> <3BFF8692.7060900@vegaa.de> <20011125023314.B30336@mikef-linux.matchmail.com> <20011125031452.B27959@thune.mrc-home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011125031452.B27959@thune.mrc-home.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2001 at 03:14:53AM -0800, Mike Castle wrote:
> On Sun, Nov 25, 2001 at 02:33:14AM -0800, Mike Fedyk wrote:
> > The newest e2fsck (1.25) will hide the file for you, just like it would be
> > if the conversion was done on an unmounted FS.
> 
> 
> Actually, to re-iterate a recent point:  No, it won't.
> 
> The next version of e2fsck should.  But 1.25 does NOT do that.
> 

Ok...

Strange that aDilger has been one to say that 1.25 does hide the file...

Since I don't know myself, I'll let others say for sure.

MF
