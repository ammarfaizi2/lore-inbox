Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265854AbTATNpZ>; Mon, 20 Jan 2003 08:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265857AbTATNpY>; Mon, 20 Jan 2003 08:45:24 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:47011 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id <S265854AbTATNpX>; Mon, 20 Jan 2003 08:45:23 -0500
Message-ID: <60396.1043070563692.JavaMail.nobody@web55.us.oracle.com>
Date: Mon, 20 Jan 2003 05:49:23 -0800 (PST)
From: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
To: davej@codemonkey.org.uk
Subject: Re: "Latitude with broken BIOS" ?
Cc: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-Mailer: Oracle Webmail Client
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Mon, Jan 20, 2003 at 05:28:49AM -0800, Alessandro Suardi wrote:
>
>  > >  >  "Dell Latitude with broken BIOS detected. Refusing to enable the local APIC."
>  > >
>  > > Lots of Dell laptops (like other vendors) crash instantly when trying to
>  > > enable the APIC.
>  >
>  > Well my Dells power off on rebooting from 2.5... bug 119 or 134 in
>  >  http://bugme.osdl.org, no need to resort to messing with the APIC ;(
>
> That one IMO looks like an ACPI problem (Note ACPI != APIC)

More like PM in general, happens with my older Latitude with APM as well
 (I was making a point of ease of crashing, not confusing APIC and ACPI ;)

--alessandro
