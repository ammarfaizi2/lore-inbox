Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316886AbSIBJN4>; Mon, 2 Sep 2002 05:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318249AbSIBJN4>; Mon, 2 Sep 2002 05:13:56 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:20231 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S316886AbSIBJNw>; Mon, 2 Sep 2002 05:13:52 -0400
Message-ID: <3D732CD0.9CD1FCE1@aitel.hist.no>
Date: Mon, 02 Sep 2002 11:18:08 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.32 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: =?iso-8859-1?Q?M=E5ns=20Rullg=E5rd?= <mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Disabling disk cache for single fs
References: <yw1x7ki8ttxq.fsf@sandwich.e.kth.se>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:
> 
> Is there a way to disable the disk cache for one filesystem?  I don't
> want mp3s to waste all the cache that could be used better.
> 
> If there isn't a way, what would be a good way to implement it?  As a
> mount option?

I believe the correct way is to enhance your mp3 player(s)
with the use of madvise()

Helge Hafting
