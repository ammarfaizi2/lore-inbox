Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVCSVmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVCSVmt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 16:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVCSVmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 16:42:49 -0500
Received: from smtp817.mail.sc5.yahoo.com ([66.163.170.3]:64873 "HELO
	smtp817.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261855AbVCSVms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 16:42:48 -0500
From: Russell Miller <rmiller@duskglow.com>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Suspend-to-disk woes
Date: Sat, 19 Mar 2005 13:44:03 -0800
User-Agent: KMail/1.7
Cc: erik.andren@gmail.com, linux-kernel@vger.kernel.org
References: <423B01A3.8090501@gmail.com> <200503191220.35207.rmiller@duskglow.com> <20050319212922.GA1835@elf.ucw.cz>
In-Reply-To: <20050319212922.GA1835@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503191344.03379.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 March 2005 13:29, Pavel Machek wrote:
> On So 19-03-05 12:20:35, Russell Miller wrote:
> > On Saturday 19 March 2005 05:26, Pavel Machek wrote:
> > > Checking that would be hard, but you might want to provide patch to
> > > check last-mounted dates of filesystems and panic if they changed.
> > > 				Pavel
> >
> > Then how would you fix it?  There'd also have to be a way to reset it,
>
> boot with "noresume", then mkswap.
> 									Pavel
Ah, makes sense.

I've never used the resume functionality, so my ignorance on that subject is 
understandable... :-)

--Russell

-- 

Russell Miller - rmiller@duskglow.com - Agoura, CA
