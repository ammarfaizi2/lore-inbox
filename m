Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbTAREsV>; Fri, 17 Jan 2003 23:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262414AbTAREsV>; Fri, 17 Jan 2003 23:48:21 -0500
Received: from mail.webmaster.com ([216.152.64.131]:57323 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S262395AbTAREsU> convert rfc822-to-8bit; Fri, 17 Jan 2003 23:48:20 -0500
From: David Schwartz <davids@webmaster.com>
To: <jamie@shareable.org>, Larry McVoy <lm@bitmover.com>,
       <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.63 (1077) - Licensed Version
Date: Fri, 17 Jan 2003 20:57:18 -0800
In-Reply-To: <20030118043309.GA18658@bjl1.asuk.net>
Subject: Re: Is the BitKeeper network protocol documented?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Message-ID: <20030118045719.AAA8414@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	I'm starting to think that one cannot legally use BitKeeper as the 
preferred means of developing a GPLed program. The problem is, the 
GPL defines the source as the preferred base to modify the software 
from and requires you to be able to distribute the source without any 
additional licensing requirements.

	If BitKeeper is the version management tool, then BitKeeper is part 
of the source by this definition. Providing the source in BK form 
without BK is as useless as providing it encrypted. Providing it in 
any other form does not satisfy the GPL (assuming that BK form is in 
fact the preferred way of modifying it).

	DS


