Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbWBCVLf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbWBCVLf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 16:11:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030201AbWBCVLf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 16:11:35 -0500
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:60095 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1030196AbWBCVLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 16:11:35 -0500
Message-ID: <43E3C703.20501@lwfinger.net>
Date: Fri, 03 Feb 2006 15:11:31 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.16-c2
References: <43E39932.4000001@lwfinger.net> <Pine.LNX.4.64.0602031007420.4630@g5.osdl.org> <43E3A001.7080309@lwfinger.net> <20060203205716.7ed38386@localhost> <43E3BF5A.3040305@lwfinger.net> <Pine.LNX.4.64.0602031258300.4630@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602031258300.4630@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> You can also edit the file that describe your shorthand notation. If you 
> normally do "git pull origin" just look into the ".git/remotes/origin" 
> file, and I think you'll find it very obvious what it all does.
> 
> (If you used a really old version of git to create the archive originally, 
> it might be ".git/branches/origin" instead).
> 
> 		Linus
> 


Thanks. I was almost ready to create aliases so that I would not have to remember all those paths. 
My initial copy of git was obviously new enough that .git/remotes/origin had the info. Now rid of rsync.

Thanks again,

Larry
