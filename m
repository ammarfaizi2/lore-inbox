Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTEJRfN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 13:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264456AbTEJRfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 13:35:13 -0400
Received: from AGrenoble-101-1-4-215.w217-128.abo.wanadoo.fr ([217.128.202.215]:34196
	"EHLO awak") by vger.kernel.org with ESMTP id S264455AbTEJRfN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 13:35:13 -0400
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
From: Xavier Bestel <xavier.bestel@free.fr>
To: Tuncer M zayamut Ayaz <tuncer.ayaz@gmx.de>
Cc: jamie@shareable.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <S264449AbTEJRZH/20030510172507Z+7050@vger.kernel.org>
References: <1405.1052575075@www9.gmx.net>
	 <1052575167.16165.0.camel@dhcp22.swansea.linux.org.uk>
	 <S264332AbTEJO5e/20030510145734Z+7011@vger.kernel.org>
	 <S264373AbTEJPSN/20030510151813Z+1648@vger.kernel.org>
	 <20030510162527.GD29271@mail.jlokier.co.uk>
	 <S264444AbTEJQk4/20030510164056Z+1652@vger.kernel.org>
	 <S264449AbTEJRZH/20030510172507Z+7050@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-15
Organization: 
Message-Id: <1052588866.1013.3.camel@bip.localdomain.fake>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 10 May 2003 19:47:47 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le sam 10/05/2003 à 19:35, Tuncer M zayamut Ayaz a écrit :

> rebooted with a reconfigured kernel to assure it's not cpufreq.
> same behaviour without cpufreq.

You should perhaps try to enable/disable APM idle calls ..

	Xav

