Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281530AbRKUAZy>; Tue, 20 Nov 2001 19:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281531AbRKUAYn>; Tue, 20 Nov 2001 19:24:43 -0500
Received: from viper.haque.net ([66.88.179.82]:63715 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S281530AbRKUAYc>;
	Tue, 20 Nov 2001 19:24:32 -0500
Date: Tue, 20 Nov 2001 19:24:19 -0500
Subject: Re: File size limit exceeded with mkfs
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v475)
Cc: Jason Tackaberry <tack@auc.ca>, linux-kernel@vger.kernel.org
To: Andreas Dilger <adilger@turbolabs.com>
From: "Mohammad A. Haque" <mhaque@haque.net>
In-Reply-To: <20011120163523.F1308@lynx.no>
Message-Id: <1A7AE531-DE16-11D5-980E-00306569F1C6@haque.net>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.475)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday, November 20, 2001, at 06:35 PM, Andreas Dilger wrote:

> That is unfortunate, since a lot of things changed in 2.4.10, so it will
> make tracking the change hard.  Yet, I am running 2.4.13 and have no 
> such
> problems (well, at least I think not).  I don't have a spare partition >
> 2GB, but I can do the following without problems, which _should_ be the
> same thing:

could it be glibc 2.1.3 specific? i _think_ thats what I saw when the 
first round of reports came in (2.2.x users reported no problems).

--

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                                mhaque@haque.net

   "Alcohol and calculus don't mix.             Developer/Project Lead
    Don't drink and derive." --Unknown          http://www.themes.org/
                                                batmanppc@themes.org
=====================================================================

