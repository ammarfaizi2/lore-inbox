Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbUDYGtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUDYGtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 02:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUDYGtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 02:49:16 -0400
Received: from [81.219.144.6] ([81.219.144.6]:52740 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S261505AbUDYGtN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 02:49:13 -0400
Message-ID: <408B5F5B.1090802@pointblue.com.pl>
Date: Sun, 25 Apr 2004 07:48:59 +0100
From: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
Cc: ncunningham@linuxmail.com, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: fix error handling in "not enough swap space"
References: <4089DC36.5020806@pointblue.com.pl> <opr6xykbzqruvnp2@laptop-linux.wpcb.org.au> <4089E761.5050708@pointblue.com.pl> <opr6x0o10uruvnp2@laptop-linux.wpcb.org.au> <4089F0E5.3050006@pointblue.com.pl> <20040424183505.GB2525@elf.ucw.cz>
In-Reply-To: <20040424183505.GB2525@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>That's bad. That's even without swsusp, right? Again, test on 2.6.5
>and post test case. Something is probably wrong in 2.6.6-bk. 
>  
>
Yes, it is working fine on 2.6.5. I can investigate my self in spare 
time. If you have any ideas, hints, or test procedures I can follow, 
tell me. I know C very good.

--
GJ

