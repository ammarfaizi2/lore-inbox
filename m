Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293441AbSCOWlA>; Fri, 15 Mar 2002 17:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293445AbSCOWkv>; Fri, 15 Mar 2002 17:40:51 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:16535 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S293441AbSCOWkj>; Fri, 15 Mar 2002 17:40:39 -0500
Message-ID: <3C92785F.37BCE323@delusion.de>
Date: Fri, 15 Mar 2002 23:40:31 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Robert Love <rml@tech9.net>
CC: "Grover, Andrew" <andrew.grover@intel.com>,
        "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Kernel powerdown
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7D03@orsmsx111.jf.intel.com> 
		<3C92731B.1366B88E@delusion.de> <1016231178.908.66.camel@phantasy>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love wrote:
> 
> I believe it includes a variant of the patch I sent.

I can't find any A7V specific workarounds in the latest ACPI patch from
sf.net, so I don't think so.

> No matter, so long as it works.  It would be nice though to know if what
> I posted works as that can easily be pushed to Marcelo and Linus.

The newer code seems to do the right thing (tm), so I'd definitely
prefer that over some mobo-specific code. It appears that the A7V isn't
broken.

> Nonetheless, the ACPI can push their next update in due time.

Yep. No rush.

-Udo.
