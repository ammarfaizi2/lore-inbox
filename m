Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbTDWJTg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 05:19:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262967AbTDWJTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 05:19:36 -0400
Received: from mout0.freenet.de ([194.97.50.131]:56784 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S262951AbTDWJTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 05:19:36 -0400
From: Fred Aberdeen <fred.aberdeen@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.20 - intel AGP update
Date: Wed, 23 Apr 2003 11:27:20 +0200
User-Agent: KMail/1.5.1
Cc: Bill Nottingham <notting@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200304231126.38437.fred.aberdeen@freenet.de>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bill,

> AGP support for i852/i855/i865.
> By David Dawes (<dawes@tungstengraphics.com>) in general; I
> believe the only addition with respect to 2.5 is the i855PM
> support added by me. Note that i855PM with integrated video
> completely untested... my laptop has a built-in Radeon.
that patch is bogus. It does not compile b/c of undefined INTEL_I865_G and so 
on.

ciao, Fred


