Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262058AbSI3NfL>; Mon, 30 Sep 2002 09:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbSI3NfL>; Mon, 30 Sep 2002 09:35:11 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:47003 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262058AbSI3NfK>; Mon, 30 Sep 2002 09:35:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Kevin Corry <corryk@us.ibm.com>
Organization: IBM
To: Andrew Morton <akpm@digeo.com>
Subject: Re: v2.6 vs v3.0
Date: Mon, 30 Sep 2002 08:08:32 -0500
X-Mailer: KMail [version 1.2]
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <200209290114.15994.jdickens@ameritech.net> <3D97F7AE.5070304@metaparadigm.com> <3D97FB9C.593849A9@digeo.com>
In-Reply-To: <3D97FB9C.593849A9@digeo.com>
MIME-Version: 1.0
Message-Id: <02093008083201.15956@boiler>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 September 2002 02:22, Andrew Morton wrote:
> Michael Clark wrote:
> >  From reading the EVMS list, it was working with 2.5.36 a couple weeks
> > ago but needs some small bio and gendisk changes to work in 2.5.39.
>
> It's going to break bigtime if someone ups and removes all the
> kiobuf code.....

I don't think that would be the case, since EVMS doesn't use kiobuf's.

Kevin Corry
corryk@us.ibm.com
http://evms.sourceforge.net/
