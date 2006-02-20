Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWBTOtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWBTOtT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030264AbWBTOtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:49:19 -0500
Received: from canadatux.org ([81.169.162.242]:38840 "EHLO
	zoidberg.canadatux.org") by vger.kernel.org with ESMTP
	id S1030266AbWBTOtS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:49:18 -0500
Date: Mon, 20 Feb 2006 15:49:13 +0100
From: Matthias Hensler <matthias@wspse.de>
To: Pavel Machek <pavel@ucw.cz>
Cc: Harald Arnesen <harald@skogtun.org>, Lee Revell <rlrevell@joe-job.com>,
       Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler?
Message-ID: <20060220144913.GA6391@kobayashi-maru.wspse.de>
Reply-To: Matthias Hensler <matthias@wspse.de>
References: <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430002.3429.4.camel@mindpipe> <20060220101532.GB21817@kobayashi-maru.wspse.de> <1140431058.3429.15.camel@mindpipe> <20060220103329.GE21817@kobayashi-maru.wspse.de> <1140434146.3429.17.camel@mindpipe> <20060220122443.GB3495@kobayashi-maru.wspse.de> <20060220132842.GC23277@atrey.karlin.mff.cuni.cz> <8764nagm2b.fsf@basilikum.skogtun.org> <20060220144254.GC1673@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20060220144254.GC1673@atrey.karlin.mff.cuni.cz>
Organization: WSPse (http://www.wspse.de/)
X-Gummibears: Bouncing here and there and everywhere
X-Face: &Tv]9SsNpb/$w8\G-O%>W02aApFW^P>[x+Upv9xQB!2;iD9Y1-Lz'qlc{+lL2Y>J(u76Jk,cJ@$tP2-M%y?^'jn2J]3C'ss_~"u?kA^X&{]h?O?@*VwgSGob73I9r}&S%ktup0k2!neScg3'HO}PU#Ac>jwNL|P@f|f*sz*cP'hi)/<JQC4|Q[$D@aQ"C{$>a=6.rc-P1vXarjVXlzClmNfcSy/$4tQz
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, Feb 20, 2006 at 03:42:54PM +0100, Pavel Machek wrote:
> Well, yep, it really depends on CPU/harddisk.

That is why a solution using LZF is needed, so either Suspend 2 or
uswsusp.

> Can you try code from suspend.sf.net? It should be as fast as
> suspend2.

I would like to have a look at it, but http://suspend.sourceforge.net/
gives me an empty directory and http://sourceforge.net/suspend/ a "page
not found".

Regards,
Matthias
