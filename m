Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290721AbSAYQvJ>; Fri, 25 Jan 2002 11:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290723AbSAYQuy>; Fri, 25 Jan 2002 11:50:54 -0500
Received: from vena.lwn.net ([206.168.112.25]:22537 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S290721AbSAYQuq>;
	Fri, 25 Jan 2002 11:50:46 -0500
Message-ID: <20020125165045.5104.qmail@eklektix.com>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: ACPI mentioned on lwn.net/kernel 
From: corbet@lwn.net (Jonathan Corbet)
In-Reply-To: Your message of "Thu, 24 Jan 2002 17:29:40 PST."
             <59885C5E3098D511AD690002A5072D3C02AB7BDF@orsmsx111.jf.intel.com> 
Date: Fri, 25 Jan 2002 09:50:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andy,

> As longtime subscribers to acpi-devel know, this seems to come up every few
> months, but the criticisms mentioned in this week's lwn.net kernel
> development summary (http://lwn.net/2002/0124/kernel.php3) prompt me to
> respond, lest my silence be taken for capitulation. ;-)

I'm sorry if you, or the other Linux ACPI developers, felt attacked by what
was written - that certainly wasn't the intent.  Everything that appeared
in LWN had to do with the ACPI specification, and not any particular
implementation.  I don't doubt that I could have written it in a clearer,
more even-handed way.

It may well be that the concerns over ACPI are overblown.  It is true,
however, that the concerns exist and are widely shared.  It would be
worthwhile to have a discussion on why people shouldn't worry.  What
controls are there on the things AML code can do?  What reasons are there
to expect that ACPI code will be more reliable than any other sort of BIOS
code? 

Increasingly, it seems that it will not be possible to use modern hardware
without ACPI.  So, in a sense, the point will be moot.  Certainly it is
only a good thing that Linux has a high-quality ACPI implementation in the
works, so that users will have the option to use it.  I expect that most
will happily run it and look no further.  

But that doesn't change the fact that a lot of people do not like the ACPI
standard.  There is some selling yet to be done if that dislike is to be
overcome. 

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
