Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261572AbSKCDKp>; Sat, 2 Nov 2002 22:10:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261573AbSKCDKp>; Sat, 2 Nov 2002 22:10:45 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:32273 "EHLO
	ns.higherplane.net") by vger.kernel.org with ESMTP
	id <S261572AbSKCDKp>; Sat, 2 Nov 2002 22:10:45 -0500
Date: Sun, 3 Nov 2002 14:15:31 +1100
From: john slee <indigoid@higherplane.net>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: linux-kernel@vger.kernel.org, tytso@mit.edu,
       olaf.dietsche#list.linux-kernel@t-online.de, dax@gurulabs.com
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021103031530.GA1120@higherplane.net>
References: <200211030031.gA30V8a505209@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211030031.gA30V8a505209@saturn.cs.uml.edu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 07:31:08PM -0500, Albert D. Cahalan wrote:
> I have to wonder, just how many setuid executables do people have?

i've run perfectly sane webservers with suid only on /bin/su.  a few
errors are spat out, but things tend to work.  in all honesty i'm yet to
see many other uses for it in a server-admin'd-by-small-group-of-people
situation, except perhaps for sendmail.

al's idea with the mount flags did perk up the old ears though, i would
like to see this done.

j.

-- 
toyota power: http://indigoid.net/
