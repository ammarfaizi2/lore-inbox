Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288953AbSCKTQI>; Mon, 11 Mar 2002 14:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288967AbSCKTQC>; Mon, 11 Mar 2002 14:16:02 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:63758 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S288953AbSCKTPt>; Mon, 11 Mar 2002 14:15:49 -0500
Message-ID: <3C8D0260.8070700@namesys.com>
Date: Mon, 11 Mar 2002 22:15:44 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: elenstev@mesatop.com
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.33.0203110508080.17717-100000@mhw.ULib.IUPUI.Edu> <3C8CD687.5000608@namesys.com> <200203111540.IAA11492@tstac.esa.lanl.gov> <200203111755.KAA11787@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:

>
>
>I fiddled around a bit with VMS, and it looks like the following command set things
>up for me so that I only have one version for any new files I create:
>
>SET DIRECTORY/VERSION_LIMIT=1 SYS$SYSDEVICE:[USERS.STEVEN]
>
>This change was persistant across logins.  Hope this helps.
>
>Steven
>
>
This affects all directories and all files for user steven, or just one 
directory?

Hans


