Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289979AbSAOPwC>; Tue, 15 Jan 2002 10:52:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289981AbSAOPv6>; Tue, 15 Jan 2002 10:51:58 -0500
Received: from [200.10.161.32] ([200.10.161.32]:58781 "EHLO lila.inti.gov.ar")
	by vger.kernel.org with ESMTP id <S289979AbSAOPvn>;
	Tue, 15 Jan 2002 10:51:43 -0500
Message-ID: <3C44506E.C8F515B2@inti.gov.ar>
Date: Tue, 15 Jan 2002 12:53:18 -0300
From: salvador <salvador@inti.gov.ar>
Reply-To: salvador@inti.gov.ar
Organization: INTI
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: es-AR, en, es
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org
Subject: Re: Penelope builds a kernel
In-Reply-To: <20020114165909.A20808@thyrsus.com> <200201142244.g0EMimd32377@vindaloo.ras.ucalgary.ca> <20020114174523.E23081@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:

> Richard Gooch <rgooch@ras.ucalgary.ca>:
> > You know, I'm not really interested in whether Melvin or Penelope get
> > a root or not, and it's never occurred to me that kernel design should
> > be based on that.
>
> The phrase "get a root" is entertainingly ambiguous in this context, is it not?
>
> Storytelling is the most effective form of exposition.

Yes, if you mean "to confuse people" ;-)

> It's a way to pull
> technical issues out of the realm of abstraction,

Or get really out of topic. Be careful with your examples, sometimes they have
small errors here and there and the result, even when looks coherent, is invalid.

> and help designers
> realize that there are (at least potentially) real people involved.

Eric, if you want to create a tool that looks for the installed hardware/vendor
configuratio/etc. and from all of this information creates a configure file in the
Linux source tree go ahead. I don't think anybody will stop you if that's a
separated tool and not part of the Linux source tree.
Lets use an example, looks like you really like examples:

1) You create a project called "Linux autoconf".
2) You make it available as a tarball.
3) Some user that likes it downloads and installs the Linux kernel sources.
4) Same user downloads your "nice" tool and also installs it.
5) This user instead of using the traditional configuration methods just runs your
tool and gets all solved .... or all fkd up ;-)

I don't think anybody will stop you from doing such a tool, in fact nobody can,
but you'll need to look for help in other list ;-))

SET

--
Salvador Eduardo Tropea (SET). (Electronics Engineer)
Visit my home page: http://welcome.to/SetSoft or
http://www.geocities.com/SiliconValley/Vista/6552/
Alternative e-mail: set@computer.org set@ieee.org
Address: Curapaligue 2124, Caseros, 3 de Febrero
Buenos Aires, (1678), ARGENTINA Phone: +(5411) 4759 0013



