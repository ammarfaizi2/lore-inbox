Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312414AbSDJDWS>; Tue, 9 Apr 2002 23:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312417AbSDJDWR>; Tue, 9 Apr 2002 23:22:17 -0400
Received: from 202-77-223-23.outblaze.com ([202.77.223.23]:43485 "EHLO
	testdcc.outblaze.com") by vger.kernel.org with ESMTP
	id <S312414AbSDJDWR>; Tue, 9 Apr 2002 23:22:17 -0400
Message-ID: <20020410032212.29074.qmail@fastermail.com>
Content-Type: multipart/mixed; boundary="----------=_1018408932-28940-0"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "mark manning" <mark.manning@fastermail.com>
To: <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Date: Tue, 09 Apr 2002 22:22:12 -0500
Subject: Re: nanosleep
X-Originating-Ip: 67.241.61.228
X-Originating-Server: ws4.hk5.outblaze.com
X-DCC-Outblaze-Metrics: testdcc.outblaze.com 100; env_From=5 From=5 Message-ID=1 Received=1 Body=1
	Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1018408932-28940-0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

hi - yes i read the man pages, im already using nanosleep for doing 1 second delays and i chose nanosleep because a signal can interrupt the delay which might be useful (and might not :)

----- Original Message -----
From: Mark Hahn <hahn@physics.mcmaster.ca>
Date: Tue, 9 Apr 2002 20:32:03 -0400 (EDT)
To: mark manning <mark.manning@fastermail.com>
Subject: Re: nanosleep


> > could someone show me how to do a delay of N miliseconds using nanosleep ?
> > (given n delay n mili seconds etc) - i cant seem to get my code to work
> > doh! 
> 
> did you read the fine man page, esp the section on resolution
> and busy-waits?  also, using select for its timeout is probably
> more portable.
> 
> 

-- 

_______________________________________________
Get your free email from http://www.fastermail.com

Powered by Outblaze

------------=_1018408932-28940-0--
