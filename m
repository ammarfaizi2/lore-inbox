Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262414AbTANMgF>; Tue, 14 Jan 2003 07:36:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTANMgF>; Tue, 14 Jan 2003 07:36:05 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:25233 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S262414AbTANMgF>;
	Tue, 14 Jan 2003 07:36:05 -0500
Date: Tue, 14 Jan 2003 12:41:52 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Vadlapudi Madhu <Vadlapudi.Madhu@cse.iitkgp.dhs.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       "Vadlapudi.Madhu - 01cs6020" <vmadhu@cse.iitkgp.dhs.org>
Subject: Re: Is linux kernel is available for any AMD processors?
Message-ID: <20030114124152.GA3137@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Vadlapudi Madhu <Vadlapudi.Madhu@cse.iitkgp.dhs.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	"Vadlapudi.Madhu - 01cs6020" <vmadhu@cse.iitkgp.dhs.org>
References: <20030113140855.GH9031@codemonkey.org.uk> <Pine.GSO.4.21.0301141317494.27333-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0301141317494.27333-100000@vervain.sonytel.be>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 01:18:39PM +0100, Geert Uytterhoeven wrote:
 > > All of AMD's CPUs should work fine with the standard kernel.
 > > They'll boot a generic 'i386' kernel, or you can compile
 > > specific kernels optimised for Athlon/Duron.
 > 
 > Don't know which AMD CPUs the original poster intended, but i386 kernels don't
 > boot on Am29000. Yes, AMD produced non-i386 compatible CPUs as well.

Ach, yes. Easy mistake to make when 'all your worlds an x86'

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
