Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283204AbSAIOTI>; Wed, 9 Jan 2002 09:19:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286758AbSAIOS7>; Wed, 9 Jan 2002 09:18:59 -0500
Received: from [203.162.56.202] ([203.162.56.202]:30472 "HELO
	mail.vnsecurity.net") by vger.kernel.org with SMTP
	id <S282843AbSAIOSq>; Wed, 9 Jan 2002 09:18:46 -0500
Content-Type: text/plain; charset=US-ASCII
From: MrChuoi <MrChuoi@yahoo.com>
Reply-To: MrChuoi@yahoo.com
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Subject: Re: [BUG] Error reading multiple large files
Date: Wed, 9 Jan 2002 21:25:24 +0700
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0201091454060.6953-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0201091454060.6953-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020109141833.749934E4FD@mail.vnsecurity.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 09 January 2002 08:56 pm, Roy Sigurd Karlsbakk wrote:
> > you really should try akpm's "[patch, CFT] improved disk read latency"
> > patch.  it sounds almost perfect for your application.
>
> hi
>
> It seemed like it helped first, but after a while, some 99 processes went
> Defunct, and locked. After this, the total 'bi' as reported from vmstat
> went down to ~ 900kB per sec
>
> What should I do? Run Windoze?
Windoze can do it better ? :-\
