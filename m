Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131305AbRDMNo3>; Fri, 13 Apr 2001 09:44:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131308AbRDMNoT>; Fri, 13 Apr 2001 09:44:19 -0400
Received: from tomts6.bellnexxia.net ([209.226.175.26]:37790 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S131305AbRDMNoM>; Fri, 13 Apr 2001 09:44:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 8139too 'too much work at interrupt'
Date: Fri, 13 Apr 2001 09:44:09 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <01041300501001.06447@oscar>
In-Reply-To: <01041300501001.06447@oscar>
MIME-Version: 1.0
Message-Id: <01041309440900.00436@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Forgot to mention that reverting to the driver too
the version in ac3 cures the problem I am seeing.

Ed

On Friday 13 April 2001 00:50, Ed Tomlinson wrote:
> Upgraded to ac5 tonight.  It stalled shortly after start a
> program to suck news.  Looking at a serial console I see
> hundreds of the above message with a status of
> intrStatus = 0x0001
>
> Sysrq was active on the serial console so I did a T and P
> before syncing are rebooting...  If the translated traces
> are of any use just ask.
>
> Ed Tomlinson <tomlins@cam.org>
