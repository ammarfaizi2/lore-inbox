Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292318AbSBPFF0>; Sat, 16 Feb 2002 00:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292319AbSBPFFQ>; Sat, 16 Feb 2002 00:05:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21260 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S292318AbSBPFFD>;
	Sat, 16 Feb 2002 00:05:03 -0500
Message-ID: <3C6DE87C.FA96D1D6@mandrakesoft.com>
Date: Sat, 16 Feb 2002 00:05:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Robert Love <rml@tech9.net>, "Eric S. Raymond" <esr@thyrsus.com>,
        Arjan van de Ven <arjan@pc1-camc5-0-cust78.cam.cable.ntl.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <20020215135557.B10961@thyrsus.com> <200202151929.g1FJTaU03362@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215141433.B11369@thyrsus.com> <20020215195818.A3534@pc1-camc5-0-cust78.cam.cable.ntl.com> <20020215145421.A12540@thyrsus.com> <20020215213833.J27880@suse.de> <1013810923.807.1055.camel@phantasy> <20020215232832.N27880@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
>  Increased functionality I don't have a problem with, as long
>  as other more important things are addressed.  And for that matter,
>  Linus has said to Eric "I don't care, take this out of the
>  kernel completely leaving just oldconfig'.

That's a good point, and one I would be happy with.  (or, ditch -all-
current config code, and replace with the existing mconfig)

Eric's configurator definitely seems to have a place with users.  Making
kernel configuration easier for the masses is more than fine with me... 
Impacting kernel developers' productivity and workflow because of this
is more of what I object to...

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
