Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285216AbSACJzZ>; Thu, 3 Jan 2002 04:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285226AbSACJzP>; Thu, 3 Jan 2002 04:55:15 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:52358
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285216AbSACJzK>; Thu, 3 Jan 2002 04:55:10 -0500
Date: Thu, 3 Jan 2002 04:42:14 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Miles Lane <miles@megapathdsl.net>
Cc: Andrew Rodland <arodland@noln.com>, LKML <linux-kernel@vger.kernel.org>,
        David Relson <relson@osagesoftware.com>
Subject: Re: CML2 funkiness
Message-ID: <20020103044214.A8217@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Miles Lane <miles@megapathdsl.net>,
	Andrew Rodland <arodland@noln.com>,
	LKML <linux-kernel@vger.kernel.org>,
	David Relson <relson@osagesoftware.com>
In-Reply-To: <web-54762827@admin.nni.com> <1010022168.1142.12.camel@stomata.megapathdsl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1010022168.1142.12.camel@stomata.megapathdsl.net>; from miles@megapathdsl.net on Wed, Jan 02, 2002 at 05:42:47PM -0800
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miles Lane <miles@megapathdsl.net>:
> I am seeing other problems.  Using CML2 with a 2.4.18-pre1
> tree, I was unable to create a kernel that would boot.
> It kept crashing with messages stating that the rivafb driver
> did not support 8-bit color depth.  I tried tweaking my
> configuration for a while, but finally reverted to CML2
> and was then able to get a working kernel.  I'll investigate
> further and send along a diff of the working and broken
> configuration files.

This sounds like a rulebase bug.  That diff should pin it down.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The spirit of resistance to government is so valuable on certain occasions, 
that I wish it always to be kept alive.  It will often be exercised when 
wrong, but better so than not to be exercised at all. I like a little 
rebellion now and then.	-- Thomas Jefferson, letter to Abigail Adams, 1787
