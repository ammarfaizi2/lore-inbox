Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbWBTKdf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbWBTKdf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:33:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbWBTKde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:33:34 -0500
Received: from canadatux.org ([81.169.162.242]:13264 "EHLO
	zoidberg.canadatux.org") by vger.kernel.org with ESMTP
	id S964848AbWBTKde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:33:34 -0500
Date: Mon, 20 Feb 2006 11:33:29 +0100
From: Matthias Hensler <matthias@wspse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@suse.cz>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220103329.GE21817@kobayashi-maru.wspse.de>
Reply-To: Matthias Hensler <matthias@wspse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz> <200602110116.57639.sebas@kde.org> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430002.3429.4.camel@mindpipe> <20060220101532.GB21817@kobayashi-maru.wspse.de> <1140431058.3429.15.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1140431058.3429.15.camel@mindpipe>
Organization: WSPse (http://www.wspse.de/)
X-Gummibears: Bouncing here and there and everywhere
X-Face: &Tv]9SsNpb/$w8\G-O%>W02aApFW^P>[x+Upv9xQB!2;iD9Y1-Lz'qlc{+lL2Y>J(u76Jk,cJ@$tP2-M%y?^'jn2J]3C'ss_~"u?kA^X&{]h?O?@*VwgSGob73I9r}&S%ktup0k2!neScg3'HO}PU#Ac>jwNL|P@f|f*sz*cP'hi)/<JQC4|Q[$D@aQ"C{$>a=6.rc-P1vXarjVXlzClmNfcSy/$4tQz
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, Feb 20, 2006 at 05:24:18AM -0500, Lee Revell wrote:
> On Mon, 2006-02-20 at 11:15 +0100, Matthias Hensler wrote:
> > Isn't this what happend with swusp? I tried it of a period of time
> > when it was included in mainline, it was just buggy and nothing much
> > improved. 
> 
> And you never explained why you can't try a recent version...

I said I surely will :-)

However, there wasn't a recent version until a short time before. I just
did what you do in situations where you need a working solution: you
stick to the most promising thing. While swsusp looked abandoned there
was a huge work going on with Suspend 2.

As work started again on swsusp recently I will try that, but from what
I have read so far it looks like swsusp is scheduled to become
deprecated anyway and work will be put into uswsusp. That is all I
complain about, it means throwing away everything that is working, or
easy to get it working, and delaying working hibernate support for
another time.

Regards,
Matthias
