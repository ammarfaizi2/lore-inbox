Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267099AbTBHVIs>; Sat, 8 Feb 2003 16:08:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267101AbTBHVIs>; Sat, 8 Feb 2003 16:08:48 -0500
Received: from ns.unixsol.org ([193.110.159.2]:53777 "HELO ns.unixsol.org")
	by vger.kernel.org with SMTP id <S267099AbTBHVIr>;
	Sat, 8 Feb 2003 16:08:47 -0500
Message-ID: <3E45741E.5000308@unixsol.org>
Date: Sat, 08 Feb 2003 23:18:22 +0200
From: Georgi Chorbadzhiyski <gf@unixsol.org>
Organization: Unix Solutions Ltd. (http://unixsol.org)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030130
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: adam@yggdrasil.com
Subject: Re: 2.5.59-mm9
References: <20030207095004$5ef0@gated-at.bofh.it> <87lm0sszhw.fsf@jupiter.jochen.org>
In-Reply-To: <87lm0sszhw.fsf@jupiter.jochen.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jochen Hein wrote:
> Andrew Morton <akpm@digeo.com> writes:
> 
> 
>>. Adam's cleanup and cutdown of devfs has been put back in again.  We
>>  really need devfs users to test this and to report, please.  (And not just
>>  to me!  I'll only bounce it to Adam J.  Richter <adam@yggdrasil.com>
>>  anyway)
> 
> 
> Ok, I patched 2.5.59 with Adam's patch and it boots fine.  I miss the
> file /dev/.devfsd - Debian uses that file to detect devfs and act
> accordingly.  Still in the first minutes, I'll get back when Linus has

Slackware does the same.

> released 2.5.60 (I'll probably switch back to a stock kernel then).


-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/

