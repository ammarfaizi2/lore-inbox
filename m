Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132506AbRCZRwX>; Mon, 26 Mar 2001 12:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132518AbRCZRwP>; Mon, 26 Mar 2001 12:52:15 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:2056 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132506AbRCZRwH>;
	Mon, 26 Mar 2001 12:52:07 -0500
Date: Mon, 26 Mar 2001 12:54:53 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: John Cowan <cowan@mercury.ccil.org>, Peter Samuelson <peter@cadcamlab.org>,
        "Eric S. Raymond" <esr@snark.thyrsus.com>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML1 cleanup patch
Message-ID: <20010326125453.A18646@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Rik van Riel <riel@conectiva.com.br>,
	John Cowan <cowan@mercury.ccil.org>,
	Peter Samuelson <peter@cadcamlab.org>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <E14hVd6-0007eK-00@mercury.ccil.org> <Pine.LNX.4.21.0103261153510.1863-100000@imladris.rielhome.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0103261153510.1863-100000@imladris.rielhome.conectiva>; from riel@conectiva.com.br on Mon, Mar 26, 2001 at 11:55:02AM -0300
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br>:
> What's wrong with using the _file type_ for these things ?

I don't understand that.
 
> Conversely, why can't CML2 use the CONFIG_ prefix to
> determine if a symbol is a configuration option, like
> we're doing now?

I do understand this.  Greg Banks pointed it out last night, and I'm
testing a CML2 version that implements it now.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The two pillars of `political correctness' are, 
  a) willful ignorance, and
  b) a steadfast refusal to face the truth
	-- George MacDonald Fraser
