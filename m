Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289727AbSBES6G>; Tue, 5 Feb 2002 13:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289761AbSBES5r>; Tue, 5 Feb 2002 13:57:47 -0500
Received: from natwar.webmailer.de ([192.67.198.70]:12221 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S289727AbSBES5k>; Tue, 5 Feb 2002 13:57:40 -0500
Date: Tue, 5 Feb 2002 19:38:56 +0100
From: Kristian <kristian.peters@korseby.net>
To: Brandon Low <lostlogic@lostlogicx.com>
Cc: starfire@dplanet.ch, linux-kernel@vger.kernel.org
Subject: Re: New scheduler in 2.4. series?
Message-Id: <20020205193856.7628dcb3.kristian.peters@korseby.net>
In-Reply-To: <20020204163513.A31041@lostlogicx.com>
In-Reply-To: <20020204231938.18755478.starfire@dplanet.ch>
	<20020204163513.A31041@lostlogicx.com>
X-Mailer: Sylpheed version 0.7.0claws5 (GTK+ 1.2.10; i386-redhat-linux)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brandon Low <lostlogic@lostlogicx.com> wrote:
> Seeing the new scheduler in 2.4 would be nice!  However, soon wouldn't be nice, because there are a lot of 3rd party kernel 
> modules that try to make calls against the old scheduler that don't seem to work.  My personal case in point is Bestcrypt 
> ( www.jetico.sci.fi ).  Just my thoughts on the matter.

If you're speaking of Ingo's O1-scheduler I won't vote for inclusion now. I still have some trouble with high priority nice levels (renice -20). For some seconds the system gets totally unresponsive for user requests while switching between those processes. The last one I've tried was J2.

*Kristian

  :... [snd.science] ...:
 ::
 :: http://www.korseby.net
 :: http://gsmp.sf.net
  :.........................:: ~/$ kristian@korseby.net :
