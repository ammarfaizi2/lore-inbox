Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315429AbSFYAqZ>; Mon, 24 Jun 2002 20:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315430AbSFYAqY>; Mon, 24 Jun 2002 20:46:24 -0400
Received: from mta02bw.bigpond.com ([139.134.6.34]:63941 "EHLO
	mta02bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S315429AbSFYAqY>; Mon, 24 Jun 2002 20:46:24 -0400
From: Brad Hards <bhards@bigpond.net.au>
To: Christian Robert <xtian-test@sympatico.ca>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday problem
Date: Tue, 25 Jun 2002 10:43:28 +1000
User-Agent: KMail/1.4.5
References: <3D17BB4B.F5E2571F@sympatico.ca>
In-Reply-To: <3D17BB4B.F5E2571F@sympatico.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200206251043.28051.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2002 10:37, Christian Robert wrote:
>   gettimeofday (&tv, NULL);
How about checking the return value of the function call?

Brad
-- 
http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds in Black.
