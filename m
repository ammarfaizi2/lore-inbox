Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292707AbSCMIKG>; Wed, 13 Mar 2002 03:10:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292705AbSCMIJ4>; Wed, 13 Mar 2002 03:09:56 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:6925 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S289272AbSCMIJm>;
	Wed, 13 Mar 2002 03:09:42 -0500
Message-ID: <3C8F0944.5050804@namesys.com>
Date: Wed, 13 Mar 2002 11:09:40 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020310
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Pimlott <andrew@pimlott.ne.mediaone.net>
CC: James Antill <james@and.org>, Larry McVoy <lm@bitmover.com>,
        Tom Lord <lord@regexps.com>, jaharkes@cs.cmu.edu,
        linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.GSO.4.21.0203110051500.9713-100000@weyl.math.psu.edu> <3C8C4B8A.2070508@namesys.com> <nn4rjmoh02.fsf@code.and.org> <3C8DB535.7080807@namesys.com> <20020312223738.GB29832@pimlott.ne.mediaone.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Pimlott wrote:

>On Tue, Mar 12, 2002 at 10:58:45AM +0300, Hans Reiser wrote:
>
>>Clearcase handles all of this in the filesystem, and it all works pretty 
>>much reasonably.
>>
>
>This is misleading--Clearcase stores versions on top a normal
>filesystem (like most other RCS's), and all manipulation is entirely
>in user-space (over the network to server processes).  There only
>filesystem magic is that there are directories you cannot list (plus
>permission semantics are a little funny).
>
>Seems very different from what you're proposing, IIUC.
>
>Andrew
>
>
I am sorry, but arguing over whether network filesystems have their 
functionality outside the filesystem is not an argument I respect enough 
to engage in.  Clearcase is a filesystem.  Views are built into the 
filesystem.
It has user space utilities.  It is still a filesystem despite having 
user space utilities, and its functionality is in the filesystem.  

Hans


