Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbTDFTNV (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 15:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263056AbTDFTNV (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 15:13:21 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16527
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263055AbTDFTNU (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 15:13:20 -0400
Subject: Re: poweroff problem
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
Cc: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E906FF5.202@gmx.net>
References: <20030405060804.31946.qmail@webmail5.rediffmail.com>
	 <20030406233319.042878d3.sfr@canb.auug.org.au>
	 <20030406155814.68c5c908.us15@os.inf.tu-dresden.de>
	 <20030407002703.16993dc4.sfr@canb.auug.org.au>
	 <20030406174655.592b7f60.us15@os.inf.tu-dresden.de>
	 <1049639095.963.0.camel@dhcp22.swansea.linux.org.uk>
	 <20030406183713.3435d742.us15@os.inf.tu-dresden.de>
	 <1049642082.1218.3.camel@dhcp22.swansea.linux.org.uk>
	 <20030406200411.2c33a06f.us15@os.inf.tu-dresden.de>  <3E906FF5.202@gmx.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049653578.1600.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 19:26:19 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 19:20, Carl-Daniel Hailfinger wrote:
> > I can't find any specific A7V workarounds in 2.5.66 ACPI code, so I guess
> > the ACPI code in 2.4 isn't up-to-date.
> > 
> > The original poster's problem is then probably indeed related to a buggy BIOS
> > if it doesn't even powerdown with APM.
> 
> The original poster said his kernel was 2.4.2-2, which looks like a 
> RedHat one and could have contained ACPI...

No Red Hat production kernel so far contains ACPI. As the reliability improves
and the quality of BIOS ACPI code rises that may change.

2.4.2 is also obsolete, and about five erratas back including security
ones.

