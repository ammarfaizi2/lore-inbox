Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314595AbSEFRCQ>; Mon, 6 May 2002 13:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314596AbSEFRCP>; Mon, 6 May 2002 13:02:15 -0400
Received: from postman.arcor-online.net ([151.189.0.87]:23305 "EHLO
	postman.arcor-online.net") by vger.kernel.org with ESMTP
	id <S314595AbSEFRCP>; Mon, 6 May 2002 13:02:15 -0400
Date: Mon, 6 May 2002 19:00:36 +0200
From: Stefan Frank <sfr@gmx.net>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre8 compile error [in drivers/char/serial.c]
Message-ID: <20020506170036.GA855@asterix>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020506114143.GA26760@asterix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the false alarm. "Problem" solved. I had modified the SUBLEVEL
field in the Makefile. Set it back to 19 and all is well now.


Bye, Stefan

-- 
If Machiavelli were a hacker, he'd have worked for the CSSG.
		-- Phil Lapsley
