Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273358AbRJDKmR>; Thu, 4 Oct 2001 06:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273345AbRJDKmG>; Thu, 4 Oct 2001 06:42:06 -0400
Received: from i212.netz.at ([194.152.163.212]:24840 "EHLO pixelwings.com")
	by vger.kernel.org with ESMTP id <S273358AbRJDKlr>;
	Thu, 4 Oct 2001 06:41:47 -0400
Date: Thu, 04 Oct 2001 12:42:17 +0200
From: Clemens Schwaighofer <cs@pixelwings.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [POT] Which journalised filesystem ?  (fwd)
Message-ID: <746710000.1002192137@gullevek.piwi.intern>
In-Reply-To: <E15oqKN-00058k-00@calista.inka.de>
In-Reply-To: <E15oqKN-00058k-00@calista.inka.de>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bernd Eckenfels

--On Wednesday, October 03, 2001 08:01:03 PM +0200 you wrote:

> In article <706340000.1002116485@gullevek.piwi.intern> you wrote:
>> but to the point of that thread. we had reiser FS on a production server
>> (Fileserver for NFS, Samba & Appletalk) and we nothing but troubles. It
>> was an 2.2.16 kernel and i dunno witch reiserfs we used. But from this
>> point forward I dun think I will use it again soon on a production
>> server.
>
> Do you had NFS Problems or do you had filesystem problems?

Filesystem Problems. Massive problems. It went so far, that the system was 
so unstable, that I had to reboot it almost everyday.

> Because NFS interaction with Journaled Filesystems is/was an issue with
> those recent kernels, as far as i understand.

I might have came from NFS, AppleTalk, Samba, who knows. But I couldn't go 
into detail testing, and I needed to fix it up. I might try ext3 one, cause 
I work with it at home and I am quite happy with it, but it's just a home 
system not a production enviroment ...

--
"Freiheit ist immer auch die Freiheit des Andersdenkenden"
Rosa Luxemburg, 1871 - 1919
mfg, Clemens Schwaighofer              PIXELWINGS Medien AG
Kandlgasse 15/5, A-1070 Wien           T: [+43 1] 524 58 50
JETZT NEU! MIT FEWA GEWASCHEN --> http://www.pixelwings.com
