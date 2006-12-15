Return-Path: <linux-kernel-owner+w=401wt.eu-S1751753AbWLOK0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbWLOK0Y (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 05:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751761AbWLOK0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 05:26:24 -0500
Received: from mailgw1.uni-kl.de ([131.246.120.220]:55697 "EHLO
	mailgw1.uni-kl.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753AbWLOK0X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 05:26:23 -0500
X-Greylist: delayed 668 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 05:26:22 EST
Date: Fri, 15 Dec 2006 11:13:30 +0100
From: Eduard Bloch <edi@gmx.de>
To: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
Cc: Scott Preece <sepreece@gmail.com>, Chris Wedgwood <cw@f00f.org>,
       Eric Sandeen <sandeen@sandeen.net>,
       Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Message-ID: <20061215101330.GA15243@debian>
References: <Pine.LNX.4.64.0612131954530.5718@woody.osdl.org> <458171C1.3070400@garzik.org> <Pine.LNX.4.64.0612140855250.5718@woody.osdl.org> <20061214170841.GA11196@tuatara.stupidest.org> <20061214173827.GC3452@infradead.org> <20061214175253.GB12498@tuatara.stupidest.org> <458194B8.1090309@sandeen.net> <20061214183956.GA13692@tuatara.stupidest.org> <7b69d1470612141142k63cc7d11l89c0a7f26acc631a@mail.gmail.com> <4581A75C.9020509@wolfmountaingroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4581A75C.9020509@wolfmountaingroup.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

#include <hallo.h>
* Jeff V. Merkey [Thu, Dec 14 2006, 12:34:52PM]:
> 
> This whole effort is pointless.  This is the same kind of crap MICROSOFT 
> DOES to create incompatibilities

Just my 0.02¤ - one of the things I wonder about is why eg. class*
interfaces has been replaced with something "protected" by GPL enforcing
macros. What is the point? Nobody wins. The access to the new fine-grained
system has been restricted for users, and distributors (yes, I maintain
a such module) have to work around this in-kernel restriction
and create cludges.

Greg (and others from the "every touch of my bits is a derivation of it
and I need to protect it" party)  - what are you thinking? Do you
seriously think that such restrictions would help anyone? IMO protecting
the access to interfaces is an utterly stupid idea in the free software
world.

Eduard.

-- 
<Ref|ex> Geht 'n Mantafahrer zum Manta-Treffen.
         Fragt: Fährt hier wer Manta
		-- #Debian.DE
