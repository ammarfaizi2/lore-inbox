Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316891AbSFDWdh>; Tue, 4 Jun 2002 18:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316902AbSFDWdg>; Tue, 4 Jun 2002 18:33:36 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:63739 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316891AbSFDWdf>; Tue, 4 Jun 2002 18:33:35 -0400
Subject: Re: PROBLEMS to compile ataraid.c in kernel-2.5.20
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: system_lists@nullzone.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20020605000918.00cb74f8@192.168.2.131>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Jun 2002 00:39:05 +0100
Message-Id: <1023233945.11583.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-06-04 at 23:10, system_lists@nullzone.org wrote:
> i got this error messages trying to get mi ataraid hardware on.
> can any help me please? i have the system stoped waiting for this.

Ataraid needs major work for 2.5 yet. Its built around a lot of 2.4
assumptions that the new I/O layer has rendered incorrect

