Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262083AbTCVKNj>; Sat, 22 Mar 2003 05:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262085AbTCVKNj>; Sat, 22 Mar 2003 05:13:39 -0500
Received: from [65.171.77.208] ([65.171.77.208]:40205 "EHLO
	mx.digitalmortgage.cc") by vger.kernel.org with ESMTP
	id <S262083AbTCVKNi>; Sat, 22 Mar 2003 05:13:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Denis Perchine <dyp@perchine.com>
Organization: AcademSoft Ltd.
To: linux-kernel@vger.kernel.org
Subject: Re: VIA Rhine timeouts
Date: Sat, 22 Mar 2003 16:24:38 +0600
User-Agent: KMail/1.4.3
References: <20030321232047.D7D771800D2@smtp-2.hotpop.com> <20030322101720.GA18378@k3.hellgate.ch>
In-Reply-To: <20030322101720.GA18378@k3.hellgate.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303221624.38768.dyp@perchine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 22 March 2003 16:17, Roger Luethi wrote:
> > (in fact, an onboard chip in the ECS L7VTA-L motherboard)
> > completely refuses to make a connection under 2.4.x kernels.
> > I tried all releases between 2.4.18 and current 2.4.21-pre5
> > to no avail. The driver provided by VIA at their site
> > fared no better.
> > [...]
> > The weird thing is, it seems to work perfectly with
> > Debian Woody's stock 2.2.20 idepci kernel. I'd be glad
>
> If you have APIC support on, try turning it off.

Is someone working on fixing APIC for VIA motherboards?

--
Denis

