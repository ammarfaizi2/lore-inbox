Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbTDZRcz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 13:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTDZRcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 13:32:55 -0400
Received: from lmail.actcom.co.il ([192.114.47.13]:56493 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262685AbTDZRcy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 13:32:54 -0400
Message-ID: <3EAAC588.9010806@shemesh.biz>
Date: Sat, 26 Apr 2003 20:44:40 +0300
From: Shachar Shemesh <lkml@shemesh.biz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en, he
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Zack Brown <zbrown@tumblerings.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ChangeLog suggestion
References: <Pine.LNX.4.44.0304260924190.2276-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0304260924190.2276-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>The thing is, the stuff that already _is_ in the changelog is certainly 
>enough to identify the email if you just have a reasonable search engine. 
>You have author, comments and diff, and if that isn't enough to identify 
>the thing then something is wrong.
>  
>
Slightly OT:
Note that the "author" info is only semi readable from CVS. It contains 
just the user part of the email address (in my case - "lkml" for spam 
reasons - hardly a unique identifier). I'm told that under BK it has the 
full email, so I'm not sure where that stands there.

This does mean that under CVS, this info is not searchable, nor even 
guarenteed unique.

             Shachar

-- 
Shachar Shemesh
Open Source integration consultant
Home page & resume - http://www.shemesh.biz/


