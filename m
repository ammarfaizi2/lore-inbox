Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288288AbSAMX1C>; Sun, 13 Jan 2002 18:27:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288289AbSAMX0w>; Sun, 13 Jan 2002 18:26:52 -0500
Received: from cj379137-a.indpdnce1.mo.home.com ([24.179.182.153]:19204 "EHLO
	ns.brink.cx") by vger.kernel.org with ESMTP id <S288288AbSAMX0p>;
	Sun, 13 Jan 2002 18:26:45 -0500
From: Andrew Brink <abrink@ns.brink.cx>
Date: Sun, 13 Jan 2002 17:26:30 -0600
To: linux-kernel@vger.kernel.org
Subject: Getting Out of Memory errors at random intervals.
Message-ID: <20020113232630.GA1149@ns.brink.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. I've been getting random Out of Memory: Killing Processs pid (name)
On _two_ different boxes. One is running 2.4.16 while the other 
is 2.4.17.  Most of the time the process that gets killed is apache
(these boxen are webservers) but sometimes its mysql, exim, htdig and
others.

These boxes used to be rock stable, and now they get the OOM error at
random periodic times.

Is there anything I can check for, or do to clear this up?

Any help would be greatly appreciated.
Thanks,
Andrew Brink
