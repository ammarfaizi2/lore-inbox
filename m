Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132574AbRCZUKO>; Mon, 26 Mar 2001 15:10:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132573AbRCZUKD>; Mon, 26 Mar 2001 15:10:03 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:46856 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132571AbRCZUJr>;
	Mon, 26 Mar 2001 15:09:47 -0500
Date: Mon, 26 Mar 2001 15:12:23 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, trini@kernel.crashing.org,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML1 cleanup patch, take 3
Message-ID: <20010326151223.A20023@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Jeff Garzik <jgarzik@mandrakesoft.com>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>, torvalds@transmeta.com,
	alan@lxorguk.ukuu.org.uk, trini@kernel.crashing.org,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200103261924.f2QJOwL19694@snark.thyrsus.com> <3ABF9EA7.FD7EEAED@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3ABF9EA7.FD7EEAED@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Mar 26, 2001 at 02:55:19PM -0500
Organization: Eric Conspiracy Secret Labsnamespace-management
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com>:
> Wow, your script was longer than your patch :)

But independent of the version/patchlevel, which was the point of shipping it.

If CML2 is adopted and I become the config system maimtainer,
symbolreplace is one of a number of small tools I'll drop into the scripts
directory to address the namespace-management problem.  At over 1800
symbols, power tools are needed.  Even just garbage-collecting unused
symbols isn't trivial.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"The power to tax involves the power to destroy;...the power to
destroy may defeat and render useless the power to create...."
	-- Chief Justice John Marshall, 1819.
