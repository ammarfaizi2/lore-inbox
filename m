Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280056AbRKDXgP>; Sun, 4 Nov 2001 18:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280059AbRKDXgF>; Sun, 4 Nov 2001 18:36:05 -0500
Received: from bitmover.com ([192.132.92.2]:38814 "EHLO bitmover.bitmover.com")
	by vger.kernel.org with ESMTP id <S280056AbRKDXgA>;
	Sun, 4 Nov 2001 18:36:00 -0500
Date: Sun, 4 Nov 2001 15:36:00 -0800
From: Larry McVoy <lm@bitmover.com>
To: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: CVS / Bug Tracking System
Message-ID: <20011104153600.M19938@work.bitmover.com>
Mail-Followup-To: Bernd Eckenfels <ecki@lina.inka.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <flk.1004824861.fsf@jens.unfaehig.de> <E160Epp-0008Sa-00@calista.inka.de> <20011103215634.A10051@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011103215634.A10051@work.bitmover.com>; from lm@bitmover.com on Sat, Nov 03, 2001 at 09:56:34PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 03, 2001 at 09:56:34PM -0800, Larry McVoy wrote:
> and if you'd like to take it for a test drive, we've put up just the stuff
> you need at
> 
> 	http://www.bitkeeper.com/promerge.tgz
> 
> You don't need BitKeeper installed to run it

Andrew Pimlott politely pointed out that this isn't true, and here's the fix:

	tar zxf promerge.tgz
	cd promerge
	cat > bk
	exit 0
	^D
	chmod +x bk
	PATH=$PATH:$PWD ./RUN_ME

Sorry about that.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
