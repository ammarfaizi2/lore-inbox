Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261689AbSLFK3E>; Fri, 6 Dec 2002 05:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262258AbSLFK3D>; Fri, 6 Dec 2002 05:29:03 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:20974 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S261689AbSLFK3D>; Fri, 6 Dec 2002 05:29:03 -0500
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
From: Arjan van de Ven <arjanv@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@digeo.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20021206021559.GK9882@holomorphy.com>
References: <20021206111326.B7232@turing.une.edu.au>
	<3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random>
	<3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> 
	<20021206021559.GK9882@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 06 Dec 2002 11:36:15 +0100
Message-Id: <1039170975.1432.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 64GB isn't getting any testing that I know of; I'd hold off until
> someone's actually stood up and confessed to attempting to boot
> Linux on such a beast. Or until I get some more RAM. =)

United Linux at least has tested this according to
http://www.unitedlinux.com/en/press/pr111902.html
Hardware functionality is exploited through advanced features such as
large memory support for up to 64 GB of RAM

so I'm sure Andrea's VM deals with it gracefully
