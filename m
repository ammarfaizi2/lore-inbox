Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135345AbREFK2f>; Sun, 6 May 2001 06:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135413AbREFK20>; Sun, 6 May 2001 06:28:26 -0400
Received: from p3EE3C993.dip.t-dialin.net ([62.227.201.147]:36100 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S135345AbREFK2R>; Sun, 6 May 2001 06:28:17 -0400
Date: Sun, 6 May 2001 12:28:16 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: CML2 <linux-kernel@vger.kernel.org>
Cc: "Eric S. Raymond" <esr@thyrsus.com>, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.4.0, aka "brutality and heuristics"
Message-ID: <20010506122816.B8590@emma1.emma.line.org>
Mail-Followup-To: CML2 <linux-kernel@vger.kernel.org>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010504205312.A27435@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010504205312.A27435@thyrsus.com>; from esr@thyrsus.com on Fri, May 04, 2001 at 20:53:12 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 May 2001, Eric S. Raymond wrote:

> Sigh...now, I hope, we can get back to solving problems that I don't
> expect to be so rare they're lost in the statistical noise.  It's not
> good to get so obsessed about finding clever solutions to corner cases
> that one loses sight of the larger issues.

The problem about rare cases is that they don't get proper testing, so
bugs may slip through and go unnoticed for an extended amount of time
without even being documented.
