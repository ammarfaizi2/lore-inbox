Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317662AbSGaCtT>; Tue, 30 Jul 2002 22:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317660AbSGaCtT>; Tue, 30 Jul 2002 22:49:19 -0400
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.227]:1439 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S317662AbSGaCtS>; Tue, 30 Jul 2002 22:49:18 -0400
Message-ID: <3D474F48.1030109@linux.org>
Date: Tue, 30 Jul 2002 22:45:28 -0400
From: John Weber <john.weber@linux.org>
Organization: Linux Online
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020702
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: janitorial PATCH: 2.4:  nvram.c Lindent
References: <3D47170E.20003@sun.com> <ai75c5$1ft$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If you're doing these kinds of Lindent changes, you might as well also
> fix another non-linuxism:
> 
> 	return (x);	->	return x;
> 
> I don't know why some people seem to think that "return" is a function
> with an argument..

Excuse me?  Anyone care to explain?

> I guess that one isn't mentioned in the CodingStyles thing. I'm lazy.
> Bad Bad Linus.


