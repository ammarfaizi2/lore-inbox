Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265046AbTFCPS2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265047AbTFCPS2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:18:28 -0400
Received: from camus.xss.co.at ([194.152.162.19]:19725 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S265046AbTFCPSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:18:24 -0400
Message-ID: <3EDCBF64.6060807@xss.co.at>
Date: Tue, 03 Jun 2003 17:31:48 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schlemmer <azarah@gentoo.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: system clock speed too high?
References: <3EDBA83B.5050406@xss.co.at>	 <1054582573.7494.51.camel@dhcp22.swansea.linux.org.uk>	 <3EDC7052.9060109@xss.co.at> <3EDC8DC0.7090009@xss.co.at>	 <3EDC96EA.5020906@xss.co.at>	 <1054645247.9359.12.camel@dhcp22.swansea.linux.org.uk>	 <3EDCAF61.3060202@xss.co.at> <1054651781.5268.66.camel@workshop.saharacpt.lan>
In-Reply-To: <1054651781.5268.66.camel@workshop.saharacpt.lan>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Martin Schlemmer wrote:
> On Tue, 2003-06-03 at 16:23, Andreas Haumer wrote:
>
>
>>The "USB legacy support" settings slipped through when
>>I was preparing the system. I was too much concentrated
>>on the ACPI/Fusion MPT problems...
>>
>>But something must be wrong in this area, as the kernel prints
>>this "..MP-BIOS bug: 8254 timer not connected to IO-APIC"
>>message when USB legacy support is disabled.
>>
[...]
>
> What about contacting the manufacturer to fix the bios ?
>
It's on my TODO list, but I want to do some more tests first.

The Asus AP1700-S5 does officially list Linux as supported OS,
(and it's a really nice piece of server hardware, too), so they
should be definitely interested in fixing this. It might be not
so clear who's to blame for this problem, though.

Is anyone from ASUSTeK Computers Inc. around here on this list?

- - andreas

- --
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+3L9gxJmyeGcXPhERAh8OAJ9uCh3S60u9RTGYyfg2TN3PDKc8RwCfWu7S
1fdoACA6B+7FjKxzXsM+xQs=
=OoCm
-----END PGP SIGNATURE-----

