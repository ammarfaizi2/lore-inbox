Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135369AbRADVBP>; Thu, 4 Jan 2001 16:01:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129436AbRADVA4>; Thu, 4 Jan 2001 16:00:56 -0500
Received: from [209.24.233.229] ([209.24.233.229]:62986 "HELO
	penguincomputing.com") by vger.kernel.org with SMTP
	id <S135315AbRADVAg>; Thu, 4 Jan 2001 16:00:36 -0500
Date: Thu, 4 Jan 2001 13:00:27 -0800 (PST)
From: "Brett G. Person" <bperson@penguincomputing.com>
To: Helge Hafting <helgehaf@idb.hist.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown?
In-Reply-To: <3A544925.B9BF4241@idb.hist.no>
Message-ID: <Pine.LNX.4.10.10101041258110.1745-100000@mailserver.penguincomputing.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well. How does tivo handle this situation?  Certainly, there are instances
when your power will fail in your home and your Tivo will be without
juice. When it powers back on what does it do to check the fs?  Does it
need to check the fs?


Brett G. Person
415-358-2656
bperson@penguincomputing.com

Penguin Computing - The World's Most Reliable Linux Systems


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
