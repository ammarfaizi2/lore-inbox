Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316823AbSEVBfa>; Tue, 21 May 2002 21:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316825AbSEVBf3>; Tue, 21 May 2002 21:35:29 -0400
Received: from relay1.pair.com ([209.68.1.20]:50698 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S316823AbSEVBf2>;
	Tue, 21 May 2002 21:35:28 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3CEAF6F2.BB70395D@kegel.com>
Date: Tue, 21 May 2002 18:40:02 -0700
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: khttpd and tmpfs don't get along?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've found that khttpd tends to oops when used with tmpfs.
The oops tracebacks are not especially informative.
So far, I've only verified this with ppc, but I should be
able to verify it with x86 soon.
- Dan
