Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310178AbSCKQI6>; Mon, 11 Mar 2002 11:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310179AbSCKQIt>; Mon, 11 Mar 2002 11:08:49 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:50703 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S310178AbSCKQIl>; Mon, 11 Mar 2002 11:08:41 -0500
Message-ID: <3C8CD687.5000608@namesys.com>
Date: Mon, 11 Mar 2002 19:08:39 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: elenstev@mesatop.com
CC: "Mark H. Wood" <mwood@IUPUI.Edu>, linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <Pine.LNX.4.33.0203110508080.17717-100000@mhw.ULib.IUPUI.Edu> <3C8C95D8.2070601@namesys.com> <200203111444.HAA11416@tstac.esa.lanl.gov>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole wrote:

>
>Quoting from "VMS General User's Manual", section 2.1.1 Filenames, Types,
>and Versions, "You can control the number of versions of a file by specifying 
>the /VERSION_LIMIT qualifier to the DCL commands CREATE/DIRECTORY, SET DIRECTORY, 
>and SET FILE."
>
>It has been a while (about 12 years), but IIRC, you could set /VERSION_LIMIT=1 and
>effectively get rid of the annoying versions.  But some people, the Aunt Tillie
>types, were always tripping over their shoelaces and unintentially deleting files.
>For those people, the version feature probably seemed a blessing rather than a
>curse.
>
>Steven
>
>
So with every command to create a directory you had to add an extra 
parameter specifying that you didn't want extra versions or else you got 
them?

Hans

