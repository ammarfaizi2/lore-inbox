Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137102AbREKKpE>; Fri, 11 May 2001 06:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137103AbREKKoz>; Fri, 11 May 2001 06:44:55 -0400
Received: from ns.suse.de ([213.95.15.193]:2310 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S137102AbREKKor>;
	Fri, 11 May 2001 06:44:47 -0400
Date: Fri, 11 May 2001 12:44:31 +0200
From: Andi Kleen <ak@suse.de>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Andi Kleen <ak@suse.de>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        linux-kernel@vger.kernel.org, davem@redhat.com
Subject: Re: Source code compatibility in Stable series????
Message-ID: <20010511124431.A6267@gruyere.muc.suse.de>
In-Reply-To: <20010511123257.A6023@gruyere.muc.suse.de> <200105111039.MAA18522@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200105111039.MAA18522@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Fri, May 11, 2001 at 12:39:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2001 at 12:39:29PM +0200, Rogier Wolff wrote:
> But it's always been said that source code compatiblity would be
> maintained. I'm a bit pissed that people just go about changing public
> source-level interfaces. 

2.4.4 is basically like 2.5.0 as far as networking is concerned, it includes major
fundamental changes to the stack.

-Andi
