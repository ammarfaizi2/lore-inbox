Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262520AbTCIOku>; Sun, 9 Mar 2003 09:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262521AbTCIOkt>; Sun, 9 Mar 2003 09:40:49 -0500
Received: from mailout01.sul.t-online.com ([194.25.134.80]:11723 "EHLO
	mailout01.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262520AbTCIOkr> convert rfc822-to-8bit; Sun, 9 Mar 2003 09:40:47 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Kyuma Ohta <whatisthis@jcom.home.ne.jp>, linux-kernel@vger.kernel.org
Subject: Re: Compilation error 1394 with 2.4.21-pre5
Date: Sun, 9 Mar 2003 15:51:03 +0100
User-Agent: KMail/1.4.3
References: <20030309.233406.112620195.whatisthis@jcom.home.ne.jp>
In-Reply-To: <20030309.233406.112620195.whatisthis@jcom.home.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200303091551.03862.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 09 March 2003 15:34, Kyuma Ohta wrote:

Hi Kuma,

> I built kernel 2.4.21-pre5 for AMD-k7 with gcc-3.2.3.
> And,modules refered 1394 (raw1394,sbp2,etc...) can't build cause of
> header(?).
> Error messages are below :
> ---- Compilation message ---
> In file included from raw1394.c:50:
> raw1394.h:167:field "tq" has imcomplete type
> raw1394.c: In function `__alloc_pending_rewquest'
> raw1394.c:110: warning: Implicit decraration function `HPSB_INIT_WORK'
> raw1394.c:118: confused earlier errors,bailing out
follow this thread:

http://marc.theaimsgroup.com/?l=linux-kernel&m=104633434012366&w=2

ciao, Marc
