Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135720AbRD2L03>; Sun, 29 Apr 2001 07:26:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135721AbRD2L0J>; Sun, 29 Apr 2001 07:26:09 -0400
Received: from p3EE3CB32.dip.t-dialin.net ([62.227.203.50]:46353 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S135718AbRD2L0G>; Sun, 29 Apr 2001 07:26:06 -0400
Date: Sun, 29 Apr 2001 13:21:45 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.3 2.4.4pre8: aic7xxx showstopper bug fails to detect sda
Message-ID: <20010429132145.A30588@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010428203143.A27784@oisec.net> <Pine.LNX.4.33.0104282039410.444-100000@3jane.ashpool.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0104282039410.444-100000@3jane.ashpool.org>; from poptix@poptix.net on Sat, Apr 28, 2001 at 20:47:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Apr 2001, poptix wrote:

> Howdy,
> 
> 	I've got an "Adaptec AHA-2940UW Pro Ultra SCSI host adapter" using
> the aic7xxx driver (the new one, not the old one), and have had no
> problems, I have a zip drive on ID5, and a 12X Smart & Friendly CD-RW on
> ID6, haven't had any problems on 2.4.3-ac14, or 2.4.4, just an FYI.

You're not using SCSI hard disks, are you?
