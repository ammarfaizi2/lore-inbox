Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264659AbTAELv5>; Sun, 5 Jan 2003 06:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264665AbTAELv5>; Sun, 5 Jan 2003 06:51:57 -0500
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:7187 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S264659AbTAELv4>; Sun, 5 Jan 2003 06:51:56 -0500
Date: Sun, 5 Jan 2003 13:00:29 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Jochen Friedrich <jochen@scram.de>,
       Matthias Andree <matthias.andree@gmx.de>,
       Andreas Dilger <adilger@turbolabs.com>, sam@ravnborg.org
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Documentation/BK-usage/bksend problems?
Message-ID: <20030105120029.GC5686@merlin.emma.line.org>
Mail-Followup-To: Jochen Friedrich <jochen@scram.de>,
	Andreas Dilger <adilger@turbolabs.com>, sam@ravnborg.org,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030105015444.GE29511@merlin.emma.line.org> <Pine.LNX.4.44.0301050839340.19683-100000@gfrw1044.bocc.de> <20030105075842.GA1256@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030105075842.GA1256@mars.ravnborg.org>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg schrieb am Sonntag, den 05. Januar 2003:

> I will submit this with bk sendbug now.

Thank you. It looks as though the bkbugs stuff expected the list of
interested parties in a different syntax; when I added my findings, it
complained about the real names in that list, such as "user Jochen not
found" or something like that. Looks like it's not RFC-822 "To:" header
syntax but just a set of mail addresses.

-- 
Matthias Andree
