Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317297AbSFCHam>; Mon, 3 Jun 2002 03:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317298AbSFCHal>; Mon, 3 Jun 2002 03:30:41 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:17682 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S317297AbSFCHak>; Mon, 3 Jun 2002 03:30:40 -0400
Message-ID: <3CFB1B18.218D470@aitel.hist.no>
Date: Mon, 03 Jun 2002 09:30:32 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.18-dj1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Jeff Jenkins <jefreyr@pacbell.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Newbie SMP question
In-Reply-To: <3CFB0CFE.8040501@pacbell.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Jenkins wrote:
> 
> I am familiar with a command on Solaris, namely "psrinfo".  This
> dispalys that # of CPUs on a box + additional info.  Is there a similar
> command on Linux that will display the # of CPUs on a system and any
> info about the CPUs ( make/model/etc.)?

cat /proc/cpuinfo

Helge Hafting
