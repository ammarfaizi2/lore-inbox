Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265518AbRFVVHF>; Fri, 22 Jun 2001 17:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265520AbRFVVGs>; Fri, 22 Jun 2001 17:06:48 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:20235 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S265518AbRFVVGi>;
	Fri, 22 Jun 2001 17:06:38 -0400
Date: Fri, 22 Jun 2001 17:09:45 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: Maintainers master list?
Message-ID: <20010622170945.A16757@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Rik van Riel <riel@conectiva.com.br>,
	"Holzrichter, Bruce" <bruce.holzrichter@monster.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010622160002.B16285@thyrsus.com> <Pine.LNX.4.33L.0106221753140.4442-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0106221753140.4442-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Fri, Jun 22, 2001 at 05:54:20PM -0300
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br>:
> Look, when somebody stops maintaining something, they'll
> stop sending patches. When this happens it's only natural
> that the information you want to use to generate the
> MAINTAINERS file is also out of date.

True.  Distributed metadata won't solve this problem.  It won't make the
problem any worse, either, so it's a wash on this issue.
 
> I fail to see how your idea would solve anything.

What happens now when somebody takes over responsibility for a file
or subsystem and the MAINTAINERS file doesn't get patched, either because
that person forgets to send a MAINTAINERS update or Linus doesn't 
happen to take the MAINTAINERS patch for a while?

What happens when I look at a file and it's not obvious which
subsystem it belongs to?  Sure, I can grovel through MAINTAINERS.  But
how do I know which verbal description matches the function of the
cryptically-commented or uncommented code I have in front of me?

Distributed-information problems need distributed-information
solutions.  Locality is your friend.  This crowd should know that
if anybody should.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

A human being should be able to change a diaper, plan an invasion,
butcher a hog, conn a ship, design a building, write a sonnet, balance
accounts, build a wall, set a bone, comfort the dying, take orders, give
orders, cooperate, act alone, solve equations, analyze a new problem,
pitch manure, program a computer, cook a tasty meal, fight efficiently,
die gallantly. Specialization is for insects.
	-- Robert A. Heinlein, "Time Enough for Love"
