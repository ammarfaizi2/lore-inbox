Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261902AbVBKBkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261902AbVBKBkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 20:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261999AbVBKBkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 20:40:31 -0500
Received: from pop.gmx.net ([213.165.64.20]:43652 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261902AbVBKBk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 20:40:26 -0500
X-Authenticated: #26200865
Message-ID: <420C0D53.6000008@gmx.net>
Date: Fri, 11 Feb 2005 02:41:39 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Matthew Garrett <mjg59@srcf.ucam.org>,
       Kendall Bennett <kendallb@scitechsoft.com>,
       =?ISO-8859-1?Q?Ville_Syrj=E4l=E4?= <syrjala@sci.fi>,
       Bill Davidsen <davidsen@tmr.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, ncunningham@linuxmail.org,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [ACPI] Re: [RFC] Reliable video POSTing on resume
References: <1107695583.14847.167.camel@localhost.localdomain>	 <420BB267.8060108@tmr.com> <20050210192554.GA15726@sci.fi>	 <1108066096.4085.69.camel@tyrosine>	 <9e473391050210121756874a84@mail.gmail.com>	 <1108067388.4085.74.camel@tyrosine>	 <9e47339105021012341c94c441@mail.gmail.com>	 <420BC814.4050102@scitechsoft.com> <1108069596.4085.78.camel@tyrosine> <9e47339105021013285e390e2a@mail.gmail.com>
In-Reply-To: <9e47339105021013285e390e2a@mail.gmail.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl schrieb:
> On Thu, 10 Feb 2005 21:06:36 +0000, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> 
>>On Thu, 2005-02-10 at 12:46 -0800, Kendall Bennett wrote:
>>
>>
>>>So perhaps this problem is something similar?
> 
> 
> What type of computer has the problem? Who makes it's video chips?

Samsung P35 notebook with ATI Mobility Radeon 9700.
IIRC I saw the c000:xxxx jump on my machine.

Give me code to test and I'll mail you the results in a few minutes.


Regards,
Carl-Daniel
-- 
http://www.hailfinger.org/
