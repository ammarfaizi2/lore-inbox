Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285326AbRLNLM3>; Fri, 14 Dec 2001 06:12:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285330AbRLNLMU>; Fri, 14 Dec 2001 06:12:20 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:48909 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S285326AbRLNLMN>; Fri, 14 Dec 2001 06:12:13 -0500
Message-ID: <3C19DE41.6000507@namesys.com>
Date: Fri, 14 Dec 2001 14:10:57 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Brad Boyer <flar@pants.nu>
CC: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>,
        Anton Altaparmakov <aia21@cam.ac.uk>, Nathan Scott <nathans@sgi.com>,
        Andreas Gruenbacher <ag@bestbits.at>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes  interface)
In-Reply-To: <20011214051604.723C52B54A@marcus.pants.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Boyer wrote:

>Hans Reiser wrote:
>
>>I remember that I used to be a sysadmin with some NetApp boxes that have 
>>a .snapshot directory that is invisible, and has special qualities.
>>
>>It worked.  There were no namespace collision problems.  None.
>>
>>These things can be survived by users.;-)
>>
>
>Yes, these things can be survived, but speaking as someone who currently
>has a job involving multiple NetApp boxes, I can say that the .snapshot
>directory has some seriously annoying properties that break tar and
>other programs that expect things to look normal. The snapshots have
>saved my ass a few times, but they're still a pain to work with due
>to a few little quirks. In particular, the files in the snapshot keep
>the same inode number as the actual file. Just remember that clever
>solutions that almost fit the traditional model can have strange
>results over time.
>
>	Brad Boyer
>	flar@allandria.com
>
>
>

Can you detail the problem?

Hans

