Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267110AbTAGMLb>; Tue, 7 Jan 2003 07:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267373AbTAGMLb>; Tue, 7 Jan 2003 07:11:31 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:56802 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267110AbTAGMLb>;
	Tue, 7 Jan 2003 07:11:31 -0500
Date: Tue, 7 Jan 2003 12:17:36 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3
Message-ID: <20030107121736.GA16281@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50L.0301061932140.8257-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50L.0301061932140.8257-100000@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 07:32:37PM -0200, Marcelo Tossati wrote:

 > <bero@arklinux.org>:
 >   o AGP support for VIA P4X333 boards

Bogus. Uses incorrect naming, as the P4X333 is a chipset, not
a northbridge. The P4X400 also matches this ID for eg.
Also needes s/Via/VIA/

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
