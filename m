Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280725AbRLDDNn>; Mon, 3 Dec 2001 22:13:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283671AbRLCXq1>; Mon, 3 Dec 2001 18:46:27 -0500
Received: from cs6669235-16.austin.rr.com ([66.69.235.16]:13440 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S284955AbRLCS6H>; Mon, 3 Dec 2001 13:58:07 -0500
Date: Mon, 3 Dec 2001 12:57:38 -0600 (CST)
From: Erik Elmore <lk@bigsexymo.com>
X-X-Sender: <lk@localhost.localdomain>
To: Ivanovich <ivanovich@menta.net>
cc: Mark Hahn <hahn@physics.mcmaster.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: EXT3 - freeze ups during disk writes
In-Reply-To: <01120223371700.01168@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0112031255040.1512-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

heh, that makes sense, if I want my hardware to work right, then I need to 
build the damn driver.  I added in the support and tweaked my startup 
scripts and not only did that pause go away, my throughput has improved as 
well.  Thanks guys.

Erik


