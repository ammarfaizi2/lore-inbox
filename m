Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbSLVRBH>; Sun, 22 Dec 2002 12:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbSLVRBH>; Sun, 22 Dec 2002 12:01:07 -0500
Received: from 205-158-62-139.outblaze.com ([205.158.62.139]:9108 "HELO
	spf1.us.outblaze.com") by vger.kernel.org with SMTP
	id <S265063AbSLVRBG>; Sun, 22 Dec 2002 12:01:06 -0500
Message-ID: <20021222170906.13011.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>, akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Date: Mon, 23 Dec 2002 01:09:06 +0800
Subject: Re: Poor performance with 2.5.52, load and process in D state
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws5-3.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
[...]
Just to add the result of one more test:

> Ok, I'm back with the results of the osdb test against 2.4.19 and 2.5.52
> Both the kernel booted with apm=off mem=40M
> osdb ran with 40M of data.
> To summarize the results:
> 2.4.19 "Single User Test"	806.78 seconds	(0:13:26.78)
> 2.5.52 "Single User Test"	3771.85 seconds	(1:02:51.85)
2.4.19(mem=24M) "Single User Test"	3371.98 seconds	(0:56:11.98)

Ciao,

Paolo

-- 
______________________________________________
http://www.linuxmail.org/
Now with POP3/IMAP access for only US$19.95/yr

Powered by Outblaze
