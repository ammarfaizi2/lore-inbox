Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbUIDVpm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbUIDVpm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 17:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbUIDVpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 17:45:42 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:40915 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261602AbUIDVpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 17:45:40 -0400
Subject: Re: New proposed DRM interface design
From: Lee Revell <rlrevell@joe-job.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Airlie <airlied@linux.ie>,
       Keith Whitwell <keith@tungstengraphics.com>,
       Dave Jones <davej@redhat.com>, Jon Smirl <jonsmirl@yahoo.com>,
       dri-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040904132512.B14904@infradead.org>
References: <20040904102914.B13149@infradead.org>
	 <41398EBD.2040900@tungstengraphics.com>
	 <20040904104834.B13362@infradead.org>
	 <413997A7.9060406@tungstengraphics.com>
	 <20040904112535.A13750@infradead.org>
	 <4139995E.5030505@tungstengraphics.com> <20040904112930.GB2785@redhat.com>
	 <4139A9F4.4040702@tungstengraphics.com>
	 <20040904124658.A14628@infradead.org>
	 <Pine.LNX.4.58.0409041253390.25475@skynet>
	 <20040904132512.B14904@infradead.org>
Content-Type: text/plain
Message-Id: <1094334347.6575.412.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 04 Sep 2004 17:45:48 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-04 at 08:25, Christoph Hellwig wrote:
> Okay, let's take Debian stable as an example.  How do you get an agpgart
> that deals with the i915 into the 2.4.18 kernel woody ships?

The same way you demonstrate that the driver you just wrote is stable. 
Run it for a few years and get back to them.  Or do you expect them to
take your word for it?

Stability can only be proven in the field which takes time.  Debian
stable is for a box that you will install and stick in a closet and
forget about for a year or two, and be basically guaranteed that the
hardware will fail long before the software does.

Lee

