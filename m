Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317693AbSGOXTU>; Mon, 15 Jul 2002 19:19:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317694AbSGOXTT>; Mon, 15 Jul 2002 19:19:19 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30226 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317693AbSGOXTS>; Mon, 15 Jul 2002 19:19:18 -0400
Message-ID: <3D335903.6000603@zytor.com>
Date: Mon, 15 Jul 2002 16:21:39 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020703
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-rc1-ac5
References: <200207152148.g6FLm7Q24750@devserv.devel.redhat.com>	<20020715220241Z317668-685+9887@vger.kernel.org> 	<agvl00$jjm$1@cesium.transmeta.com> <1026779299.32689.46.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
>>The file on zeus.kernel.org is just fine.  Problem is on your end.
> I fixed the file on zeus - it was originally wrong.
> 

Hmmm...

This bothers me somewhat, because a .bz2 file should not have been
created if the .gz file was corrupt, but the original poster strongly
implied that he had both the .gz file and a .bz2 file, unless your
update came in between.

	-hpa


