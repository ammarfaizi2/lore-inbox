Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262271AbRERITX>; Fri, 18 May 2001 04:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262273AbRERITN>; Fri, 18 May 2001 04:19:13 -0400
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:27657 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S262271AbRERISy>; Fri, 18 May 2001 04:18:54 -0400
Date: Fri, 18 May 2001 09:17:11 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Sasi Peter <sape@iq.rulez.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux scalability?
Message-ID: <20010518091711.B26232@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Sasi Peter <sape@iq.rulez.org>, linux-kernel@vger.kernel.org
In-Reply-To: <9e2ekt$3ua$1@cesium.transmeta.com> <Pine.LNX.4.33.0105180914560.29042-100000@iq.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0105180914560.29042-100000@iq.rulez.org>; from sape@iq.rulez.org on Fri, May 18, 2001 at 09:24:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why would you want to run a web server with 8 processors rather than four
webservers with 2 each?

Sean

On Fri, May 18, 2001 at 09:24:48AM +0200, Sasi Peter wrote:
> Hi!
> 
> I am just writing an essay, an have mentioned TUX as a performance and
> scalability linearity recort holder with TUX, referencing the specweb99
> website summary page:
> 
> http://www.spec.org/osg/web99/results/web99.html
> 
> However, taking a closer look, it turns out, that the above statement
> holds true only for 1 and 2 processor machines. Scalability already
> suffers at 4 processors, and at 8 processors, TUX 2.0 (7500) gets beaten
> by IIS 5.0 (8001), and these were measured on the same kind of box!
> 
> How come, TUX is soooo good at the lowend (1 and 2 CPUs), and scales this
> bad?
> 
> -- 
> SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
