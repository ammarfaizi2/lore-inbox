Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280434AbRKSRjF>; Mon, 19 Nov 2001 12:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280433AbRKSRi6>; Mon, 19 Nov 2001 12:38:58 -0500
Received: from smtp02.web.de ([217.72.192.151]:19740 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S280388AbRKSRih>;
	Mon, 19 Nov 2001 12:38:37 -0500
Date: Mon, 19 Nov 2001 18:37:54 +0100 (CET)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
cc: James A Sutherland <jas88@cam.ac.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: x bit for dirs: misfeature?
In-Reply-To: <01111916583804.00817@nemo>
Message-ID: <Pine.LNX.4.33.0111191835570.1486-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, vda wrote:

> I know. I'd like to hear anybody who have a directory with r!=x
> on purpose (and quite curious on that purpose). UNIX gugus, anybody?

When you have a web server running with user homepages in $HOME/www or 
similar, users need to have x set for the web server to serve their pages, 
but some users may not want all other users to see what files they have. 
Those people will have --x permission for other on their $HOME.

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

