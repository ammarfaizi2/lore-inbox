Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266217AbUH1RLY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUH1RLY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 13:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUH1RLY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 13:11:24 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:45220 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266217AbUH1RLW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 13:11:22 -0400
Subject: Re: reverse engineering pwcx
From: Lee Revell <rlrevell@joe-job.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       clemtaylor@comcast.net, qg@biodome.org, rogers@isi.edu
In-Reply-To: <1093712176.431.6806.camel@cube>
References: <1093709838.434.6797.camel@cube>
	 <1093710358.8611.22.camel@krustophenia.net>
	 <1093712176.431.6806.camel@cube>
Content-Type: text/plain
Message-Id: <1093713088.8611.30.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 28 Aug 2004 13:11:28 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 12:56, Albert Cahalan wrote:
> On Sat, 2004-08-28 at 12:25, Lee Revell wrote:
> > On Sat, 2004-08-28 at 12:17, Albert Cahalan wrote:
> >> [somebody]
> 
> > > > The LavaRnd guys examined the pixels on the actual
> > > > CCD chip.  It's 160x120.  The 'decompression' is
> > > > just interpolation.
> > > 
> > > Don't put much faith in the 160x120 number. Suppose
> > > that the chip is in a Bayer pattern, with 160x120
> > > of those. Well, how many pixels is that? Who knows.
> > > You'd sort of have 160x120, but with double the
> > > green data. Since green carries most of the luminance
> > > information, producing a larger image is reasonable.
> > 
> > Right, as someone else pointed out, this is wrong.
> > 
> > How do you account for the Slashdot poster's assertion that it's
> > physically impossible to cram 640 x 480 worth of data down a USB 1.1
> > pipe?
> 
> 640x480 uncompressed 24-bit RGB? It doesn't matter.
> 
> The suggestion of a 4x4 JPEG-like transform seems
> pretty reasonable. I'd like to see that whitepaper.
> 

This still can't be called 'True 640 x 480' by any reasonable standard. 
Philips' marketing claims exactly this.

So far I have not seen any evididence to refute QuantumG's original
assertion that the reason everyone in the know is being so tight-lipped 
is that releasing source code would prove Philips and/or Logitech guilty
of false advertising.

Lee

