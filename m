Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290740AbSBFRuE>; Wed, 6 Feb 2002 12:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290736AbSBFRt4>; Wed, 6 Feb 2002 12:49:56 -0500
Received: from smtp.mediascape.net ([212.105.192.20]:52232 "EHLO
	smtp.mediascape.net") by vger.kernel.org with ESMTP
	id <S290747AbSBFRti>; Wed, 6 Feb 2002 12:49:38 -0500
Message-ID: <3C616CB0.7080705@mediascape.de>
Date: Wed, 06 Feb 2002 18:49:36 +0100
From: Olaf Zaplinski <o.zaplinski@mediascape.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8+) Gecko/20020202
X-Accept-Language: de, en
MIME-Version: 1.0
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Warning, 2.5.3 eats filesystems
In-Reply-To: <20020205192826.GA112@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
> 2.5.3 managed to damage my ext2 filesystem (few lost directories);
> beware.
> 								Pavel

/me too. 2.5.3 ate my bookmarks.html (and perhaps other files too, I did not 
check yet). I just ran it up to the 1st freeze, then switched back to 
2.4.17. Reiserfs then did a rather long log replay...

Olaf

