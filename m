Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290790AbSBOUjE>; Fri, 15 Feb 2002 15:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290792AbSBOUip>; Fri, 15 Feb 2002 15:38:45 -0500
Received: from ns.suse.de ([213.95.15.193]:61458 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290790AbSBOUil>;
	Fri, 15 Feb 2002 15:38:41 -0500
Date: Fri, 15 Feb 2002 21:38:33 +0100
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215213833.J27880@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020215145421.A12540@thyrsus.com>; from esr@thyrsus.com on Fri, Feb 15, 2002 at 02:54:21PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 02:54:21PM -0500, Eric S. Raymond wrote:

 > > You're telling me Linus never mailed you about splitting up Configure.help ?
 > That's right.  The only time I ever saw Linus express an opinion on
 > this was in a post on lkml in which he said he didn't like the big
 > monolithic help file.  It didn't seem especially directed to me; I am
 > not the CML1 maintainer.

 I recall the threads you mention.
 I also recall at least a half dozen regular contributors agreeing
 that splitting up Configure.help was the way forward.

 > But I took it as a suggestion for CML2.  I told him I was willing to
 > do it after CML2 cutover
 
 This is something I never understood. CML1 has served us for
 10 years or so, and suddenly its declared "unfixable".
 "I'm not hacking that, I'll fix it in CML2" seemed to become
 the attitude. End result ? Linus got pissed off with your
 complaints of non-inclusion, and _fixed_ one of the CML1 problems
 (Configure.help) And how long did it take ? ISTR it was around
 an hour after his first mail was sent to you, me & Jeff.
 1 hour. Versus the year you spent procrastinating about how
 CML2 would fix it.

 Sure CML2 fixes some bits that are not easily fixed in CML1,
 but I wonder sometimes how much of it is/was fixable.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
