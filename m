Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271518AbRIBCEv>; Sat, 1 Sep 2001 22:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271522AbRIBCEn>; Sat, 1 Sep 2001 22:04:43 -0400
Received: from dsl027-137-030.nyc1.dsl.speakeasy.net ([216.27.137.30]:43081
	"EHLO perl") by vger.kernel.org with ESMTP id <S271518AbRIBCE0>;
	Sat, 1 Sep 2001 22:04:26 -0400
Date: Sun, 2 Sep 2001 02:04:43 +0000
To: linux-kernel@vger.kernel.org
Subject: Re: PPC kernel compiles fail (2.4.5 to 2.4.9 inclusive) due to ide problems/vt problems
Message-ID: <20010902020443.A19838@216.254.117.126>
In-Reply-To: <20010901125539.A17935@216.254.117.126> <20010901120900.N27811@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010901120900.N27811@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Sat, Sep 01, 2001 at 12:09:00PM -0700
From: xsdg <xsdg@softhome.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2001 at 12:09:00PM -0700, Tom Rini wrote:
> On Sat, Sep 01, 2001 at 12:55:39PM +0000, xsdg wrote:
> 
> > Please CC me as I am not subscribed to the list.  My only goal now is to get
> > a kernel running (2.4 is necessary for Airport support).  The computer is a
> > brand-new Apple TiBook.
> 
> Try 2.4.8.  I'd point you at a URL for the PPC trees, but the machine is
> moving right now.

I tried 2.4.8, which didn't work.  I did compile the airport module, but it had
unresolved symbols...  I ended up trying 2.4.9-ac1, which was the first kernel
to actually compile.  I then compiled -ac2, which did let the airport work :o)
Finally, I got a benh kernel off someone on #debianppc (openprojects), which
compiled, but which I haven't tried yet.

> -- 
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/

-- 
|---------------------------------------------------|
|             Hit any user to continue.             |
|---------------------------------------------------|
| http://xsdg.hypermart.net       xsdg@softhome.net |
|---------------------------------------------------|
