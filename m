Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135548AbRD1QZR>; Sat, 28 Apr 2001 12:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135550AbRD1QZH>; Sat, 28 Apr 2001 12:25:07 -0400
Received: from femail4.rdc1.on.home.com ([24.2.9.91]:47278 "EHLO
	femail4.rdc1.on.home.com") by vger.kernel.org with ESMTP
	id <S135548AbRD1QYt>; Sat, 28 Apr 2001 12:24:49 -0400
Message-ID: <3AEAF969.58972FB4@home.com>
Date: Sat, 28 Apr 2001 13:10:01 -0400
From: John Kacur <jkacur@home.com>
X-Mailer: Mozilla 4.73 [en] (X11; U; Linux 2.2.16-3 i586)
X-Accept-Language: en, ru, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 sluggish under fork load
In-Reply-To: <Pine.LNX.4.33.0104281322070.1159-100000@ppro.localdomain> <20010428170709.A410@kianga.local>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Peter Osterlund wrote:
>> 
>> Another thing is that the bash loop "while true ; do /bin/true ; done" is
>> not possible to interrupt with ctrl-c.

>        Same thing here.

I'm not having any problems. Just a quick question, is everyone who is
having a problem running with more than one cpu?

John Kacur
