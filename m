Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265137AbUFRNh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265137AbUFRNh5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 09:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265139AbUFRNh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 09:37:57 -0400
Received: from lgsx13.lg.ehu.es ([158.227.2.28]:57040 "EHLO lgsx13.lg.ehu.es")
	by vger.kernel.org with ESMTP id S265137AbUFRNh4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 09:37:56 -0400
From: Luis Miguel =?iso-8859-1?q?Garc=EDa_Mancebo?= <ktech@wanadoo.es>
To: kraxel@bytesex.org
Subject: About bttv and cards support
Date: Fri, 18 Jun 2004 15:37:38 +0200
User-Agent: KMail/1.6.82
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200406181537.38788.ktech@wanadoo.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Gerd and other,

do you think it would be too much difficult to make a few "knobs" in some 
place in order to change gpio and the like in bttv driver?

I say that because I have an unsupported 878 card and I'm trying to make it 
work. That feature will be very good in order to support new cards because we 
can even make an application that starts trying to test different values in 
order to find the correct one.

By the way, I sent a new card config a few weeks ago but got no reply. I don't 
know if the problem was it was not supporting some features or something like 
that. Anyways, my config stoped working (no sound) with newer kernels. This 
is for what I'm asking that knobs or adjusts from userspace.

Thanks a lot for the reply.
-- 
Luis Miguel García Mancebo
Universidad de Deusto / Deusto University
Spain

