Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310899AbSCHOsO>; Fri, 8 Mar 2002 09:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310894AbSCHOsE>; Fri, 8 Mar 2002 09:48:04 -0500
Received: from mail.internet-factory.de ([195.122.142.5]:48777 "EHLO
	mail.internet-factory.de") by vger.kernel.org with ESMTP
	id <S310888AbSCHOrq>; Fri, 8 Mar 2002 09:47:46 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Holger Lubitz <h.lubitz@internet-factory.de>
Newsgroups: lists.linux.kernel
Subject: Re: 160gb maxtor with promise ultra 100
Date: Fri, 08 Mar 2002 15:47:44 +0100
Organization: Internet Factory AG
Message-ID: <3C88CF10.A097C2A3@internet-factory.de>
In-Reply-To: <3C87C6CB.F05C3B96@internet-factory.de> <Pine.LNX.4.21_heb2.09.0203072312010.1837-100000@matan.home>
NNTP-Posting-Host: bastille.internet-factory.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Trace: darkstar.internet-factory.de 1015598864 31254 195.122.142.158 (8 Mar 2002 14:47:44 GMT)
X-Complaints-To: usenet@internet-factory.de
NNTP-Posting-Date: 8 Mar 2002 14:47:44 GMT
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19-pre2-ac3 i686)
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matan proclaimed:
> I had something similar - with 2.4.17+ide patch and PDC20265. The kernel
> hanged at exactly the same position. I moved the disk to hdg (master on
> second channel, instead of first), and it works OK.

Thanks for the hint, but this is not really an option for me. Both
drives should be master on their own channel. I would have tried with
both drives on the secondary channel, unfortunately the cable is too
short for that configuration. It would barely work for the primary, but
then I still have the hde: problem.

Holger
