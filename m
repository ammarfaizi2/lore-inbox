Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbTAKGPl>; Sat, 11 Jan 2003 01:15:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbTAKGPl>; Sat, 11 Jan 2003 01:15:41 -0500
Received: from mxout2.cac.washington.edu ([140.142.33.4]:33666 "EHLO
	mxout2.cac.washington.edu") by vger.kernel.org with ESMTP
	id <S267091AbTAKGPk>; Sat, 11 Jan 2003 01:15:40 -0500
Date: Fri, 10 Jan 2003 22:24:25 -0800 (PST)
From: "M. Johnson" <mgjohn@u.washington.edu>
To: linux-kernel@vger.kernel.org
Subject: console framebuffer scrolling speed
Message-ID: <Pine.A41.4.44.0301102211020.105386-100000@dante51.u.washington.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When using the unaccelerated framebuffer console, the speed of scrolling
up in programs like less and vi is much, much slower than the speed of
scrolling down, which makes these programs unusable on slower computers.

Does anyone know why this is, or how easily it can be fixed?

