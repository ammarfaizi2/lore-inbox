Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290772AbSBOUVW>; Fri, 15 Feb 2002 15:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290771AbSBOUVL>; Fri, 15 Feb 2002 15:21:11 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:46097
	"EHLO golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S290770AbSBOUUl>; Fri, 15 Feb 2002 15:20:41 -0500
Date: Fri, 15 Feb 2002 14:54:21 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
Message-ID: <20020215145421.A12540@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com>; from arjan@pc1-camc5-0-cust78.cam.cable.ntl.com on Fri, Feb 15, 2002 at 07:58:18PM +0000
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>:
> > But I think you know very well that the usual flow looks like this:
> > 
> > 1. You throw a patch over the wall to Linus.
> > 
> > 2. Either it shows up in the next release...
> > 
> > 3. ...or you hear a vast and echoing silence.
> 
> You're telling me Linus never mailed you about splitting up Configure.help ?

That's right.  The only time I ever saw Linus express an opinion on
this was in a post on lkml in which he said he didn't like the big
monolithic help file.  It didn't seem especially directed to me; I am
not the CML1 maintainer.

But I took it as a suggestion for CML2.  I told him I was willing to
do it after CML2 cutover, but was not sure he had considered the
ramifications for maintaining rulebase translations.  To this request
for clarification and guidance, I received no reply.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>
