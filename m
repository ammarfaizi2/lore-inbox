Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135555AbRDSFcx>; Thu, 19 Apr 2001 01:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135556AbRDSFcn>; Thu, 19 Apr 2001 01:32:43 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:23561 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135555AbRDSFcf>;
	Thu, 19 Apr 2001 01:32:35 -0400
Date: Thu, 19 Apr 2001 01:32:07 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Edward S. Marshall" <esm@logic.net>
Cc: Rik van Riel <riel@conectiva.com.br>, Richard Gooch <rgooch@atnf.csiro.au>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Cross-referencing frenzy
Message-ID: <20010419013207.B29686@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Edward S. Marshall" <esm@logic.net>,
	Rik van Riel <riel@conectiva.com.br>,
	Richard Gooch <rgooch@atnf.csiro.au>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104190400.f3J40Dm00992@mobilix.atnf.CSIRO.AU> <Pine.LNX.4.21.0104190109480.1685-100000@imladris.rielhome.conectiva> <20010418233618.A28546@labyrinth.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010418233618.A28546@labyrinth.local>; from esm@logic.net on Wed, Apr 18, 2001 at 11:36:18PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward S. Marshall <esm@logic.net>:
> Look at the filename. ;-) They're not being kept around, they just happen
> to be mentioned in the devfs ChangeLog, and esr's overzealous crossref
> tool caught them. *grin*
> 
> Perhaps the tool should be modified to exempt comments in code and files
> in Documentation/*? :-)

No.  But it should ignore change logs.  I'll fix  it to do that.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The Bible is not my book, and Christianity is not my religion.  I could never
give assent to the long, complicated statements of Christian dogma.
	-- Abraham Lincoln
