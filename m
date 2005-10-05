Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030448AbVJEXv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030448AbVJEXv0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030450AbVJEXv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:51:26 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:36322 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1030448AbVJEXvZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:51:25 -0400
Date: Thu, 6 Oct 2005 01:53:13 +0200
To: Marc Perkel <marc@perkel.com>
Cc: Nikita Danilov <nikita@clusterfs.com>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005235313.GB18080@aitel.hist.no>
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <200510050122.39307.dhazelton@enter.net> <4343694F.5000709@perkel.com> <17219.39868.493728.141642@gargle.gargle.HOWL> <4343D367.5030608@perkel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4343D367.5030608@perkel.com>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 06:21:43AM -0700, Marc Perkel wrote:
> 
> Now of you think "outside" the Linux box" you can see where people in 
> the real world would expect that if you have no rights to a file to read 
> or write to it that you shouldn't be able to delete it. In the outside 
> world it's "duh - of course"! but for thouse that are in the "Unix Cult" 
> you can't think past inodes.
> 
On the contrary.  There are read & write permissions, and there is a
separate delete permission.  What is so hard to understand about that?
(In unix, "delete permission" is implemented as a write permission on
the directory that file resides in.)  

Please get rid of your "real world" notion.  There is no need to
assume that delete permission is tied to write permission, just
because _some_ os'es are like that.  Some are not that way too,
just get over that.  

And there is nothing strange about it, if we move outside the
"computer" box.  I have various paper documents with other people's
signatures on them.  I am free to shred them if I like (although
that might be bad for business.)  But I have no kind of write permission,
altering a signed document is fakery - a criminal activity.
So - permission to delete read-only documents predates electronic
file systems, and is a concept most "real-world" people understand quite well.

Helge Hafting
