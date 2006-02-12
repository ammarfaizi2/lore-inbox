Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWBLEvh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWBLEvh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 23:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbWBLEvh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 23:51:37 -0500
Received: from main.gmane.org ([80.91.229.2]:40913 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932206AbWBLEvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 23:51:36 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: Packet writing issue on 2.6.15.1
Date: Sun, 12 Feb 2006 06:54:00 +0200
Message-ID: <pan.2006.02.12.04.54.00.314025@sci.fi>
References: <20060211103520.455746f6@silver> <m3r76a875w.fsf@telia.com> <20060211124818.063074cc@silver> <m3bqxd999u.fsf@telia.com> <20060211170813.3fb47a03@silver> <43EE446C.8010402@cfl.rr.com> <20060211211440.3b9a4bf9@silver> <43EE8B20.7000602@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cs181093116.pp.htv.fi
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Feb 2006 20:10:56 -0500, Phillip Susi wrote:

> The difference between packet mode and MRW mode is that MRW reserves 
> some of the disc for bad sector sparing, and the drive firmware handles 
> the reblocking rather than pktcdvd ( it also handles the sector 
> remapping ).  Packet mode was around first and has wider support and 
> requires less from the drive's firmware, but these days, it seems that 
> the vast majority of drives support MRW.

I don't think many DVD burners support MRW. At least that's the impression
I got from reading a lot of drive reviews. It's a strange thing because
most combo drives seem to support it. AFAIK the DVD+MRW standard is quite
new so that would explain part of it but I'm still wondering why the
drives wouldn't support CD-MRW.

-- 
Ville Syrjälä
syrjala@sci.fi
http://www.sci.fi/~syrjala/


