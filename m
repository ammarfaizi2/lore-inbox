Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293064AbSB1PQM>; Thu, 28 Feb 2002 10:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293184AbSB1PNt>; Thu, 28 Feb 2002 10:13:49 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:58657 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S293493AbSB1PJW> convert rfc822-to-8bit; Thu, 28 Feb 2002 10:09:22 -0500
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: Urban Widmark <urban@teststation.com>,
        Cyrille Chepelov <cyrille@chepelov.org>
Subject: Re: [2.4.18] OOPS in smbfs. Tested with 1.4.18rc2
Date: Thu, 28 Feb 2002 16:09:09 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0202281507560.32098-100000@cola.teststation.com>
In-Reply-To: <Pine.LNX.4.33.0202281507560.32098-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16gSBB-0001mr-00@mrvdomng1.kundenserver.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> the rest. A simple but helpful thing to do would be to see if 2.4.18-rc2
> works.

2.4.18-rc2 produced no oops, at least till now.

But there are a lot of 

smb_proc_readdir_long: name=<directory> result=-2, rcls=1, err=2
Messages in dmesg. I have not seen them in 2.4.17

