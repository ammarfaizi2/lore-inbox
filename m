Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317261AbSFSN5P>; Wed, 19 Jun 2002 09:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317884AbSFSN5O>; Wed, 19 Jun 2002 09:57:14 -0400
Received: from parmenides.zen.co.uk ([212.23.8.69]:28691 "HELO
	parmenides.zen.co.uk") by vger.kernel.org with SMTP
	id <S317261AbSFSN5N>; Wed, 19 Jun 2002 09:57:13 -0400
Message-ID: <3D108F2A.4080906@treblig.org>
Date: Wed, 19 Jun 2002 15:03:22 +0100
From: "Dave Gilbert (Home)" <gilbertd@treblig.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sylvain Le Briero <s.lebriero@free.fr>
CC: Joshua Newton <jpnewton@speakeasy.net>, linux-kernel@vger.kernel.org
Subject: Re: Incredible weirdness with eepro100?
References: <1024420841.2631.14.camel@claymore.corona> <001c01c21798$f100e230$3d5e06c7@slebriero2>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yep, a me-to I'm afraid.  We had the problem with an eepro100 on-board a 
motherboard.  Worked fine except when we copied large files and then it 
would start randomly timing out on smb/NFS.

Tried new kernels (2.4.16 I think was the last I tried); was mainly 
using the Intel drivers that were in SuSE kernels.

In the end we gave up and put a 3com 3c905 in - it has been fine ever since.

Dave

P.S. I'm not in a situation to try anthing more withit since it is a 
production server.




