Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317010AbSFKL7u>; Tue, 11 Jun 2002 07:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317011AbSFKL7t>; Tue, 11 Jun 2002 07:59:49 -0400
Received: from ns.suse.de ([213.95.15.193]:6673 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S317010AbSFKL7t>;
	Tue, 11 Jun 2002 07:59:49 -0400
Date: Tue, 11 Jun 2002 13:59:49 +0200
From: Dave Jones <davej@suse.de>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: Martin Dalecki <dalecki@evision-ventures.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.21 kill warinigs 14/19
Message-ID: <20020611135949.J13140@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0206082235240.4635-100000@penguin.transmeta.com> <3D049157.3040600@evision-ventures.com> <20020610204726.A681@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 08:47:26PM +0200, Ingo Oeser wrote:
 > The better way to solve this is to include:
 > 
 > <snip lots of emacsisms>
 > 
 > That's how I solved it with my own team mates ;-)

Without trying to degrade this into an editor troll,
those emacsisms solve 1 thing only. They allow other
emacs users to see the code as it should be.

Unfortunatly, they do bugger all in other editors,
or in tools such as diff, which leads to some
wierd looking patches at times.

sidenote: I've lost count how many times I've found
trivial bugs just by changing the indentation[*] and spotting
misplaced brackets.

        Dave.

[*] To that that matches CodingStyle.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
