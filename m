Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTJSIlQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 04:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262081AbTJSIlQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 04:41:16 -0400
Received: from users.linvision.com ([62.58.92.114]:45697 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S262070AbTJSIlP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 04:41:15 -0400
Date: Sun, 19 Oct 2003 10:41:13 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Hans Reiser <reiser@namesys.com>
Cc: "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Norman Diamond '" <ndiamond@wta.att.ne.jp>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>,
       "'linux-kernel@vger.kernel.org '" <linux-kernel@vger.kernel.org>,
       "'nikita@namesys.com '" <nikita@namesys.com>,
       "'Pavel Machek '" <pavel@ucw.cz>,
       "'Justin Cormack '" <justin@street-vision.com>,
       "'Russell King '" <rmk+lkml@arm.linux.org.uk>,
       "'Vitaly Fertman '" <vitaly@namesys.com>,
       "'Krzysztof Halasa '" <khc@pm.waw.pl>
Subject: Re: Blockbusting news, results are in
Message-ID: <20031019084113.GC21346@bitwizard.nl>
References: <785F348679A4D5119A0C009027DE33C105CDB300@mcoexc04.mlm.maxtor.com> <3F92488C.6030808@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F92488C.6030808@namesys.com>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 12:17:16PM +0400, Hans Reiser wrote:
> What are the common sources of data corruption, is one of them that the 
> drive head starts bumping the media more and more often because a 
> bearing (or something) has started to show signs of wear?

I'm not sure if the manufacturer knows. Datarecovery companies
know. 

Sources of dataloss are: 

	- Software
	- crooked platters (especially on laptop drives)
	- heads bouncing on platter
	- broken electronics. 

They more or less happen in about the same number of cases. 

The fact that we see less "high end" disks doesn't mean they break
down less. It might mean that they get sold less (true), or that the 
people that buy them make better backups (probably also true). 

	Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
