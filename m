Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTEKCS7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 22:18:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262033AbTEKCS7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 22:18:59 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:10439 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262013AbTEKCS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 22:18:59 -0400
Date: Sat, 10 May 2003 22:28:10 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: 2.5.69 strange high tone on DELL Inspiron 8100
To: "Tuncer M \"zayamut\" Ayaz" <tuncer.ayaz@gmx.de>
Cc: linux-kernel@vger.kernel.org
Message-ID: <200305102231_MC3-1-384E-4E4C@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> first, as you see in my other reply to Xavier Bestel disabling
> "apm idle call" fixed the problem, it seems, but I didn't want
> to disable those calls because of thermal reasons.

  Maybe you could set 2.5 to run at 100 Hz?  I don't know
if that's possible, but it could let you test if that's what
makes the noise so much more annoying.
