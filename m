Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283259AbRL0Xki>; Thu, 27 Dec 2001 18:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283080AbRL0Xk3>; Thu, 27 Dec 2001 18:40:29 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:52745 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S283054AbRL0XkT>;
	Thu, 27 Dec 2001 18:40:19 -0500
Date: Thu, 27 Dec 2001 21:40:47 -0200
From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
To: Dave Jones <davej@suse.de>, Steven Walter <srwalter@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] unchecked request_region's in drivers/net
Message-ID: <20011227214047.D30930@conectiva.com.br>
Mail-Followup-To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
	Dave Jones <davej@suse.de>, Steven Walter <srwalter@yahoo.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011227202345.B30930@conectiva.com.br> <Pine.LNX.4.33.0112272332540.15706-100000@Appserv.suse.de> <20011227163130.N12868@lynx.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011227163130.N12868@lynx.no>
User-Agent: Mutt/1.3.23i
X-Url: http://advogato.org/person/acme
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Dec 27, 2001 at 04:31:30PM -0700, Andreas Dilger escreveu:
> On Dec 27, 2001  23:44 +0100, Dave Jones wrote:
> 
> Well, in the past I had suggested to ESR (and he agreed) that it would
> be nice to split up the MAINTAINERS file (and maybe even Configure.help)

this already happens for the net/ directory to some degree, look at
net/README, the problem, as with MAINTAINERS, is that is way outdated,
listing Alan, for example, as the maintainer for net/core...

- Arnaldo
