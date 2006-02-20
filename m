Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964838AbWBTKU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964838AbWBTKU6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWBTKU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:20:58 -0500
Received: from canadatux.org ([81.169.162.242]:13029 "EHLO
	zoidberg.canadatux.org") by vger.kernel.org with ESMTP
	id S964838AbWBTKU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:20:57 -0500
Date: Mon, 20 Feb 2006 11:20:52 +0100
From: Matthias Hensler <matthias@wspse.de>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Pavel Machek <pavel@suse.cz>, Sebastian Kgler <sebas@kde.org>,
       kernel list <linux-kernel@vger.kernel.org>, nigel@suspend2.net,
       rjw@sisk.pl
Subject: Re: Which is simpler? (Was Re: [Suspend2-devel] Re: [ 00/10] [Suspend2] Modules support.)
Message-ID: <20060220102052.GC21817@kobayashi-maru.wspse.de>
Reply-To: Matthias Hensler <matthias@wspse.de>
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <200602091926.38666.nigel@suspend2.net> <20060209232453.GC3389@elf.ucw.cz> <200602110116.57639.sebas@kde.org> <20060211104130.GA28282@kobayashi-maru.wspse.de> <20060218142610.GT3490@openzaurus.ucw.cz> <20060220093911.GB19293@kobayashi-maru.wspse.de> <1140430269.3429.8.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1140430269.3429.8.camel@mindpipe>
Organization: WSPse (http://www.wspse.de/)
X-Gummibears: Bouncing here and there and everywhere
X-Face: &Tv]9SsNpb/$w8\G-O%>W02aApFW^P>[x+Upv9xQB!2;iD9Y1-Lz'qlc{+lL2Y>J(u76Jk,cJ@$tP2-M%y?^'jn2J]3C'ss_~"u?kA^X&{]h?O?@*VwgSGob73I9r}&S%ktup0k2!neScg3'HO}PU#Ac>jwNL|P@f|f*sz*cP'hi)/<JQC4|Q[$D@aQ"C{$>a=6.rc-P1vXarjVXlzClmNfcSy/$4tQz
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Mon, Feb 20, 2006 at 05:11:09AM -0500, Lee Revell wrote:
> On Mon, 2006-02-20 at 10:39 +0100, Matthias Hensler wrote:
> > These "big changes" is something I have a problem with, since it
> > means to delay a working suspend/resume in Linux for another
> > "short-term" (so what does it mean: 1 month? six? twelve?). 
> 
> If you have a big problem with this then ask the developer why he
> didn't submit it 1 or 6 or 12 months sooner, don't complain to the
> kernel developers.

Well, that is up to Nigel, but he did spend a lot of time to make
Suspend 2 clean and acceptable for the mainline first.

I do not complain that the patch is not inserted as it is. I too see
the problems and open issues. But that is nothing that cannot be solved.

What I complain is to start from the scratch with something which is not
necessarily better and takes a lot of time. I think uswsusp in the
current form just has too many drawbacks.

Regards,
Matthias
