Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318608AbSHPRNk>; Fri, 16 Aug 2002 13:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318626AbSHPRNk>; Fri, 16 Aug 2002 13:13:40 -0400
Received: from kraid.nerim.net ([62.4.16.95]:26131 "HELO kraid.nerim.net")
	by vger.kernel.org with SMTP id <S318608AbSHPRNi>;
	Fri, 16 Aug 2002 13:13:38 -0400
Date: Fri, 16 Aug 2002 19:19:05 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Andreas Tscharner <starfire@dplanet.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Bug in 2.4.19
Message-Id: <20020816191905.5dbc3a44.khali@linux-fr.org>
In-Reply-To: <20020816152315.19a44435.starfire@dplanet.ch>
References: <20020816093847.4ae5544e.khali@linux-fr.org>
	<20020816152315.19a44435.starfire@dplanet.ch>
Organization: http://www.linux-fr.org/
X-Mailer: Sylpheed version 0.8.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Second question, are the Zip100-drive-related errors in dmesg
> > something unusual and thus probably related to the problem?
> > 
> > > I/O error: dev 08:00, sector 0
> > > unable to read partition table
> 
> No, they are "normal". The ppa driver complains about not having a
> disk in my ZIP drive

Never had such messages with mine, and I wouldn't like them. I wonder
which software/settings lead to this. "Normal" errors should be
prevented in a clean manner, IMHO.

-- 
Jean "Khali" Delvare
http://www.ensicaen.ismra.fr/~delvare/
