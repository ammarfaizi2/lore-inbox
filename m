Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266130AbRGQLgL>; Tue, 17 Jul 2001 07:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266133AbRGQLgA>; Tue, 17 Jul 2001 07:36:00 -0400
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:25444 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S266130AbRGQLfl> convert rfc822-to-8bit; Tue, 17 Jul 2001 07:35:41 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian =?iso-8859-1?q?Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>
To: David Balazic <david.balazic@uni-mb.si>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.6-ac5 gives wrong cache info for Duron in /proc/cpuinfo
Date: Tue, 17 Jul 2001 13:34:36 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3B5413C9.2CE16AC9@uni-mb.si>
In-Reply-To: <3B5413C9.2CE16AC9@uni-mb.si>
MIME-Version: 1.0
Message-Id: <01071713343600.02787@Einstein.P-netz>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> CPU AMD Duron 700
>
> /proc/cpuinfo gives :
> cache size: 64 KB

With an Athlon I get 256KB.
So I guess, that cache size shows only the 2nd level cache size.

