Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317616AbSHHPmN>; Thu, 8 Aug 2002 11:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317619AbSHHPmN>; Thu, 8 Aug 2002 11:42:13 -0400
Received: from pop017pub.verizon.net ([206.46.170.210]:59015 "EHLO
	pop017.verizon.net") by vger.kernel.org with ESMTP
	id <S317616AbSHHPmM>; Thu, 8 Aug 2002 11:42:12 -0400
Message-ID: <3D52920B.8060601@verizon.net>
Date: Thu, 08 Aug 2002 11:45:15 -0400
From: "Anthony Russo., a.k.a. Stupendous Man" <anthony.russo@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 BUG in page_alloc.c:91
References: <3D51DB52.6000200@verizon.net> <1028810336.28882.18.camel@irongate.swansea.linux.org.uk>
X-Enigmail-Version: 0.62.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a way to tell which module it is that is setting the taint flag?
I can load each module one by one and check after each if the taint flag
is set, but
I just need to know how to tell it is set.

Once I can do that (assuming it's a module I can live without) I will
duplicate from cold boot.

Thank you.

>
>Dulplicate the problem from a cold boot without ever having loaded
>whatever module set the taint flag (ie wasnt a standard GPL one)
>
>
>  
>

-- tony
"Surrender to the Void."
<http://162.83.145.190:8080/%7Eapr/surrenderToTheVoid.mp3> -- John Lennon


