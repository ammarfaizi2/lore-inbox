Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265258AbSJaRIu>; Thu, 31 Oct 2002 12:08:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265259AbSJaRIu>; Thu, 31 Oct 2002 12:08:50 -0500
Received: from [216.239.30.242] ([216.239.30.242]:3846 "EHLO wind.enjellic.com")
	by vger.kernel.org with ESMTP id <S265258AbSJaRIr>;
	Thu, 31 Oct 2002 12:08:47 -0500
Message-Id: <200210311715.g9VHFBjt024840@wind.enjellic.com>
From: greg@wind.enjellic.com (Dr. Greg Wettstein)
Date: Thu, 31 Oct 2002 11:15:11 -0600
In-Reply-To: Dax Kelson <dax@gurulabs.com>
       "Flawed Ziff Davis eWeek 2.6 kernel article" (Oct 30, 11:52pm)
Reply-To: greg@enjellic.com
X-Mailer: Mail User's Shell (7.2.5 10/14/92)
To: Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org
Subject: Re: Flawed Ziff Davis eWeek 2.6 kernel article
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30, 11:52pm, Dax Kelson wrote:
} Subject: Flawed Ziff Davis eWeek 2.6 kernel article

> http://www.eweek.com/article2/0,3959,652846,00.asp
> 
> My favorite part:
>
> In addition, Linux is still too dependent on local user
> lists. Universal LDAP support and systemwide LDAP integration, not
> scheduled for 2.6, need to be built in. On the server, this isn't a
> big deal, but deploying desktops without comprehensive support for a
> global user directory can be a nightmare.

To be sure this doesn't belong in the kernel as it is a userspace issue.

That being said the issue is fundamentally and profoundly important to
the future of Linux penetrating the enterprise, from both the server
and the desktop perspective.  I started talking about this around 3-4
years ago but unfortunately even the major Linux vendors don't seem to
understand the ramifications of all this.

I have learned from reasonably harsh experience that the future of the
enterprise involves the ability to control access through the desktop.
The infrastructure needed to support this on an enterprise scale is
significant and in most cases core to the entire IT strategy of the
organization.  In the future anything that does not play within the
constraints and confines of the chosen user/identity management
environment simply isn't going to see the light of day in most
organizations.

So while the issue is not technically correct from the kernel
perspective it is an important issue.  One that, unfortunately, does
not seem to be well understood by many.

Greg

}-- End of excerpt from Dax Kelson

As always,
Dr. G.W. Wettstein, Ph.D.   Enjellic Systems Development, LLC.
4206 N. 19th Ave.           Specializing in information infra-structure
Fargo, ND  58102            development.
PH: 701-281-4950            
FAX: 701-281-3949           EMAIL: greg@enjellic.com
------------------------------------------------------------------------------
"Follow the path of the unsafe, independent thinker. Expose your ideas
to the dangers of controversy. Speak your mind, and fear less the label
of `crackpot' than the stigma of conformity. And on issues that seem
important to you, stand up and be counted at any cost."
                                -- Thomas J. Watson, founder of IBM
