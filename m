Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293407AbSCOWSs>; Fri, 15 Mar 2002 17:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293410AbSCOWSi>; Fri, 15 Mar 2002 17:18:38 -0500
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:5271 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S293407AbSCOWSZ>; Fri, 15 Mar 2002 17:18:25 -0500
Message-ID: <3C92731B.1366B88E@delusion.de>
Date: Fri, 15 Mar 2002 23:18:03 +0100
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.6 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
CC: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Robert Love <rml@tech9.net>
Subject: Re: [OOPS] Kernel powerdown
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7D03@orsmsx111.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Grover, Andrew" wrote:
> 
> Oh. Well then the NMI thing is a red herring. Try the latest ACPI patch from
> sf.net/projects/acpi and see if that fixes things.

The latest ACPI patch fixes it.
Sorry Robert, that makes your patch obsolete :)

-Udo.
