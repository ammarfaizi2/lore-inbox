Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290726AbSAYRAD>; Fri, 25 Jan 2002 12:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290730AbSAYQ7x>; Fri, 25 Jan 2002 11:59:53 -0500
Received: from coffee.Psychology.McMaster.CA ([130.113.218.59]:45773 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S290726AbSAYQ7t>; Fri, 25 Jan 2002 11:59:49 -0500
Date: Fri, 25 Jan 2002 12:01:11 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: <hahn@coffee.psychology.mcmaster.ca>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [right one][patch] amd athlon cooling on kt266/266a chipset
In-Reply-To: <1011977347.1788.5.camel@oscar>
Message-ID: <Pine.LNX.4.33.0201251159210.32190-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Maybe (eventually) base it off load average..? (So load >.8 its

disconnect should probably only happen after, say, n seconds of idleness.

