Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314485AbSFTNtO>; Thu, 20 Jun 2002 09:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314491AbSFTNtN>; Thu, 20 Jun 2002 09:49:13 -0400
Received: from ns.suse.de ([213.95.15.193]:25606 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S314485AbSFTNtM>;
	Thu, 20 Jun 2002 09:49:12 -0400
Date: Thu, 20 Jun 2002 15:49:01 +0200
From: Dave Jones <davej@suse.de>
To: Brad Hards <bhards@bigpond.net.au>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: (2.5.23) buffer layer error at buffer.c:2326
Message-ID: <20020620154901.D29373@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Brad Hards <bhards@bigpond.net.au>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0206192007210.1263-100000@netfinity.realnet.co.sz> <3D10E358.D82DB604@zip.com.au> <20020620125036.B3824@redhat.com> <200206202322.41275.bhards@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200206202322.41275.bhards@bigpond.net.au>; from bhards@bigpond.net.au on Thu, Jun 20, 2002 at 11:22:41PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 20, 2002 at 11:22:41PM +1000, Brad Hards wrote:
 > In addition to this, maybe tests to:
 > 1. Fail kmalloc occasionally
 > I'd like to see all of these enabled seperately as CONFIG_ options.

Arnaldo (or maybe one of the other Conectiva folks) had a patch
that did this.

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
