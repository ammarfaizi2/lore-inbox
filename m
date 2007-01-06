Return-Path: <linux-kernel-owner+w=401wt.eu-S1751156AbXAFDOo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751156AbXAFDOo (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 22:14:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbXAFDOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 22:14:44 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:46898 "EHLO scrub.xs4all.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156AbXAFDOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 22:14:43 -0500
From: Roman Zippel <zippel@linux-m68k.org>
To: Shlomi Fish <shlomif@iglu.org.il>
Subject: Re: [PATCH 2.6.20-rc3] qconf Search Dialog
Date: Sat, 6 Jan 2007 04:13:49 +0100
User-Agent: KMail/1.9.5
Cc: Sam Ravnborg <sam@ravnborg.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       linux-kernel@vger.kernel.org
References: <200701031954.36440.shlomif@iglu.org.il> <20070103210535.GA31780@uranus.ravnborg.org> <200701051244.14029.shlomif@iglu.org.il>
In-Reply-To: <200701051244.14029.shlomif@iglu.org.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701060413.52331.zippel@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 January 2007 11:44, Shlomi Fish wrote:

> > I would prefer it as separate smaller steps.
> > So one patch where you move the dialog and another where you improve
> > the search dialog.
>
> Move the dialog from where, to where, and in what respect?

Move the Find entry to a separate menu and then add improvements on top of the 
current find infrastructure and please don't just change the current 
behaviour, give the user a choice.

bye, Roman
