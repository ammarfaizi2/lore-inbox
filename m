Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314448AbSEYKas>; Sat, 25 May 2002 06:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314451AbSEYKar>; Sat, 25 May 2002 06:30:47 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:14956 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S314446AbSEYKaq>; Sat, 25 May 2002 06:30:46 -0400
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Date: Sat, 25 May 2002 12:26:54 +0200
From: Andreas Roedl <flood@flood-net.de>
In-Reply-To: <3a.2744d23a.2a20b7ec@aol.com>
Message-Id: <200205251226.54536.flood@flood-net.de>
MIME-Version: 1.0
Organization: Flood-Net
Subject: Re: can't find startup messages since april in /var/log/messages using 2.4.18
To: linux-kernel@vger.kernel.org
X-AntiVirus: OK! AvMailGate Version 6.13.0.6
	 at exciter has not found any known virus in this email.
X-Mailer: KMail [version 1.4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Am Samstag, 25. Mai 2002 11:48 schrieb Floydsmith@aol.com:
> For some strange reason I can't find where my "startup messagges" are being
> stored. I booted up twice this morning (052502) and only get only 1 line in
> /var/log/messages which is:
> May 25 05:10:05 localhost syslogd 1.3-3: restart.
>
> All boots since April 11 have only one such entry recorded. "dmesg" and a
> "vi" of "messages" show a full log journal for April 11.
> I have did a "df" and all file sytems have free space.
>
> Of course, the meesages do appear on the console at startup.
>
> Any suggestions?

Check if klogd is running.


Andi

-- 
Web:   http://www.flood-net.de/
Mail:  flood@flood-net.de
Phone: +49-(0)-30-680577-44

Windows sucks, Linux rules :-)              http://srom.zgp.org/
Watch more TV! http://www.cadsoft.de/people/kls/vdr/software.htm
Who needs DivX?                          telnet blinkenlights.nl

