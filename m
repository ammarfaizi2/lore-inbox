Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265843AbTATNfN>; Mon, 20 Jan 2003 08:35:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbTATNfM>; Mon, 20 Jan 2003 08:35:12 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:39366 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265843AbTATNfL>;
	Mon, 20 Jan 2003 08:35:11 -0500
Date: Mon, 20 Jan 2003 13:41:38 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "Latitude with broken BIOS" ?
Message-ID: <20030120134138.GA28221@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>,
	linux-kernel@vger.kernel.org
References: <7284135.1043069329179.JavaMail.nobody@web55.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7284135.1043069329179.JavaMail.nobody@web55.us.oracle.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 05:28:49AM -0800, Alessandro Suardi wrote:

 > >  >  "Dell Latitude with broken BIOS detected. Refusing to enable the local APIC."
 > > Lots of Dell laptops (like other vendors) crash instantly when trying to
 > > enable the APIC.
 > Well my Dells power off on rebooting from 2.5... bug 119 or 134 in
 >  http://bugme.osdl.org, no need to resort to messing with the APIC ;(

That one IMO looks like an ACPI problem (Note ACPI != APIC)

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
