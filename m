Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268322AbUHFXhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268322AbUHFXhE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 19:37:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268325AbUHFXhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 19:37:03 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:49108 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S268322AbUHFXgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 19:36:16 -0400
From: Bernd Schubert <bernd-schubert@web.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Sat, 7 Aug 2004 01:35:54 +0200
User-Agent: KMail/1.6.2
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       schilling@fokus.fraunhofer.de
References: <1091823988.1232.2552.camel@cube>
In-Reply-To: <1091823988.1232.2552.camel@cube>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408070136.04576.bernd-schubert@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 August 2004 22:26, Albert Cahalan wrote:
> In various emails, Joerg Schilling writes:
> > Linux users like to call cdrecord -scanbus and they like to
> > see _all_ SCSI devices from a single call to cdrecord.
>
> If you really think so, you've been smoking crack.

Please, no insults. I like this cdrecord -scanbus too, but I would like it 
more, if it would also print pure ide devices ;)
On the other hand I usually also don't care since k3b does all this stuff for 
me.

> Users _hate_ to call "cdrecord -scanbus". They don't
> see why it should be needed. The normal reaction to
> reading your documentation goes something like this:
>
> "What the fuck? Can't I just give it a device name?"

Well, the usual reaction is 'cdrecord whats that? Commandline interface, 
parameters? Hey, I want to burn a CD and don't like reading manpages for 
stuff like that'. I guess that at least 95% of all people who would like to 
burn a CD will prefer (and also use) a grahical interface.

The hole discussion which cdrecord -dev parameter to use is completely 
useless, it only effects a clear minority of developers and guys who probably 
don't like graphical interfaces at at all. Those guys should be able to adopt 
to whatever -dev option is possible.

Please, calm down and return to usefull technical discussions.

Bernd


