Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262264AbRERHS1>; Fri, 18 May 2001 03:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262265AbRERHSR>; Fri, 18 May 2001 03:18:17 -0400
Received: from iq.sch.bme.hu ([152.66.214.168]:2697 "EHLO iq.rulez.org")
	by vger.kernel.org with ESMTP id <S262264AbRERHSF>;
	Fri, 18 May 2001 03:18:05 -0400
Date: Fri, 18 May 2001 09:24:48 +0200 (CEST)
From: Sasi Peter <sape@iq.rulez.org>
To: <linux-kernel@vger.kernel.org>
Subject: Linux scalability?
In-Reply-To: <9e2ekt$3ua$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.33.0105180914560.29042-100000@iq.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am just writing an essay, an have mentioned TUX as a performance and
scalability linearity recort holder with TUX, referencing the specweb99
website summary page:

http://www.spec.org/osg/web99/results/web99.html

However, taking a closer look, it turns out, that the above statement
holds true only for 1 and 2 processor machines. Scalability already
suffers at 4 processors, and at 8 processors, TUX 2.0 (7500) gets beaten
by IIS 5.0 (8001), and these were measured on the same kind of box!

How come, TUX is soooo good at the lowend (1 and 2 CPUs), and scales this
bad?

-- 
SaPE - Peter, Sasi - mailto:sape@sch.hu - http://sape.iq.rulez.org/

