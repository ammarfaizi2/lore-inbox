Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265068AbSJRLLb>; Fri, 18 Oct 2002 07:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265069AbSJRLLb>; Fri, 18 Oct 2002 07:11:31 -0400
Received: from tml.hut.fi ([130.233.44.1]:12549 "EHLO tml-gw.tml.hut.fi")
	by vger.kernel.org with ESMTP id <S265068AbSJRLLa>;
	Fri, 18 Oct 2002 07:11:30 -0400
Date: Fri, 18 Oct 2002 14:16:25 +0300
From: Antti Tuominen <ajtuomin@morphine.tml.hut.fi>
To: Mitsuru KANDA <mk@linux-ipv6.org>
Cc: yoshfuji@linux-ipv6.org, davem@redhat.com, kuznet@ms2.inr.ac.ru,
       netdev@oss.sgi.com, linux-kernel@vger.kernel.org, pekkas@netcore.fi,
       torvalds@transmeta.com, jagana@us.ibm.com
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.43
Message-ID: <20021018111625.GA19394@morphine.tml.hut.fi>
References: <20021017162624.GC16370@morphine.tml.hut.fi> <20021018.021802.87011078.yoshfuji@linux-ipv6.org> <m3wuohq78u.wl@karaba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3wuohq78u.wl@karaba.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 02:56:33AM +0900, Mitsuru KANDA wrote:
> > [ipv6_tunnel]
> > 
> > I think this is almost ok.
> I think so.
> I know ipv6_tunnel is stable as I use.

Thanks for the vote of confidence :)

> plus:
>    (maybe not whole kernel issue)
> It is important to integrate your ipv6tunnel command into
> ifconfig(8) and/or ip(8).

Obviously we will provide patches to add that functionality to ip (and
maybe also ifconfig), if the code goes into the kernel.

Regards,

Antti

-- 
Antti J. Tuominen, Gyldenintie 8A 11, 00200 Helsinki, Finland.
Research assistant, Institute of Digital Communications at HUT
work: ajtuomin@tml.hut.fi; home: tuominen@iki.fi

