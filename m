Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278274AbRJZKUx>; Fri, 26 Oct 2001 06:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278295AbRJZKUo>; Fri, 26 Oct 2001 06:20:44 -0400
Received: from AMontpellier-201-1-4-3.abo.wanadoo.fr ([217.128.205.3]:64528
	"EHLO awak") by vger.kernel.org with ESMTP id <S278274AbRJZKUe> convert rfc822-to-8bit;
	Fri, 26 Oct 2001 06:20:34 -0400
Subject: RE: Issue wit ACPI and Promise?
From: Xavier Bestel <xavier.bestel@free.fr>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Gert-Jan Rodenburg'" <hertog@home.nl>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6B7@orsmsx111.jf.intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C42D6B7@orsmsx111.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.16.99+cvs.2001.10.22.19.14 (Preview Release)
Date: 26 Oct 2001 12:14:29 +0200
Message-Id: <1004091272.9893.129.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le ven 26-10-2001 à 01:06, Grover, Andrew a écrit :
> Please stick printk()s in drivers/acpi/events/evsci.c acpi_ev_sci_handler().
> 
> I'd like to know where in there it is hanging, and if it is ever returning.
> I don't know your level of comfortability in all this so please email me if
> you need more explicit instructions on what I'm asking for.

I've got an "I'm there" at line 73, then it hangs.

	Xav

