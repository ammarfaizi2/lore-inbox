Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289877AbSAPFrP>; Wed, 16 Jan 2002 00:47:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290361AbSAPFrF>; Wed, 16 Jan 2002 00:47:05 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:24711 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289877AbSAPFq5>; Wed, 16 Jan 2002 00:46:57 -0500
Date: Wed, 16 Jan 2002 07:45:39 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Christian Thalinger <e9625286@student.tuwien.ac.at>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: floating point exception
In-Reply-To: <1011118755.13266.0.camel@sector17.home.at>
Message-ID: <Pine.LNX.4.33.0201160743010.6146-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan 2002, Christian Thalinger wrote:

> Yes, it did happen that the segfault reoccured and there is nothing in
> the dmesg. This was also my first thought, then checked
> /var/log/messages with a tail and it stucked. No ctrl-c.

ctrl-alt-sysrq k? I'd just like to know wether your box hung completely.
Could you also run the ver_linux script in linux_scripts so that we can
get a better idea of your operating environment.

Cheers,
	Zwane Mwaikambo


