Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265446AbTAWPrR>; Thu, 23 Jan 2003 10:47:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTAWPrQ>; Thu, 23 Jan 2003 10:47:16 -0500
Received: from mail.fibrespeed.net ([216.168.105.35]:20997 "HELO
	mail.fibrespeed.net") by vger.kernel.org with SMTP
	id <S265446AbTAWPrQ>; Thu, 23 Jan 2003 10:47:16 -0500
Message-ID: <3E3010AA.4040107@fibrespeed.net>
Date: Thu, 23 Jan 2003 10:56:26 -0500
From: "Michael T. Babcock" <mbabcock@fibrespeed.net>
Organization: FibreSpeed Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: devik <devik@cdi.cz>
CC: linux-kernel@vger.kernel.org, lartc@mailman.ds9a.nl
Subject: Re: [LARTC] TCP probably broken in W2K
References: <Pine.LNX.4.33.0301231309020.518-100000@devix>
In-Reply-To: <Pine.LNX.4.33.0301231309020.518-100000@devix>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devik wrote:

>this is not exactly Linux problem but it is VERY interesting
>and as I'm linux developer I'm posting it here.
>  
>

I have Win2k and XP machines and I've had many symptoms of a broken 
TCP/IP stack in my TCP programming on those platforms.  I communicate 
with Linux 2.2.19 and 2.2.21 machines running tcpserver _a lot_ from 
these, and I have to do a number of strange things to make it all work. 
 I don't know if my layer-4 problems would help, but if they would, I 
could try and describe them for you.

-- 
Michael T. Babcock
C.T.O., FibreSpeed Ltd.
http://www.fibrespeed.net/~mbabcock


