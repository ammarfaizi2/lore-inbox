Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289317AbSA1SrL>; Mon, 28 Jan 2002 13:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289319AbSA1SrC>; Mon, 28 Jan 2002 13:47:02 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:26893 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289317AbSA1Sqv>; Mon, 28 Jan 2002 13:46:51 -0500
Message-ID: <3C559C8A.6010108@zytor.com>
Date: Mon, 28 Jan 2002 10:46:34 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en, sv
MIME-Version: 1.0
To: frank.van.maarseveen@altium.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: restoring hard linked files from zisofs/iso9660 w. RR
In-Reply-To: <20020125135545.A28897@espoo.tasking.nl> <a2s67d$8s0$1@cesium.transmeta.com> <20020128170704.A2632@espoo.tasking.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank van Maarseveen wrote:

> On Fri, Jan 25, 2002 at 09:55:57AM -0800, H. Peter Anvin wrote:
> 
>>WHAT doesn't work?
>>There is, I belive, an inode number RR attribute.  Last I checked I
>>was happily using hard links with RockRidge...
> 
> Try restoring a few hard linked files from such a CD. The links will
> break because the inodes of hard linked objects on CD do not have
> an identical inode number anymore.
> 


What do you mean with "restore" in this context... (dump/restore clearly
don't apply.)

Please give a "I used the following mkisofs options to make the CD and
then I see the following when I execute this command after mounting the CD
image with the following mount options..."

	-hpa


 


