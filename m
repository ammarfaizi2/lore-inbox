Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275129AbRIZKDg>; Wed, 26 Sep 2001 06:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275149AbRIZKD0>; Wed, 26 Sep 2001 06:03:26 -0400
Received: from relay03.cablecom.net ([62.2.33.103]:17924 "EHLO
	relay03.cablecom.net") by vger.kernel.org with ESMTP
	id <S275129AbRIZKDQ>; Wed, 26 Sep 2001 06:03:16 -0400
Message-Id: <200109261003.f8QA3cg22792@mail.swissonline.ch>
Content-Type: text/plain; charset=US-ASCII
From: Christian Widmer <cwidmer@iiic.ethz.ch>
Reply-To: cwidmer@iiic.ethz.ch
To: linux-kernel@vger.kernel.org
Subject: stack overflow?
Date: Wed, 26 Sep 2001 12:03:38 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

i saw very strange behaviour when debuging my modules and i start to think 
about stack overflow. i know that the kernel stack of eache process is some
what smaller than 8KB. but how big is the kernelstack during interrupt time
when executing tasklets?

thanks 
chris
