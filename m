Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287448AbSACE6x>; Wed, 2 Jan 2002 23:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286916AbSACE6n>; Wed, 2 Jan 2002 23:58:43 -0500
Received: from nycsmtp1out.rdc-nyc.rr.com ([24.29.99.226]:11695 "EHLO
	nycsmtp1out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S287448AbSACE61>; Wed, 2 Jan 2002 23:58:27 -0500
Message-ID: <3C33E4ED.3020609@nyc.rr.com>
Date: Wed, 02 Jan 2002 23:58:21 -0500
From: John Weber <weber@nyc.rr.com>
Organization: WorldWideWeber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: More errors compiling kernel with GCC 3.1
In-Reply-To: <fa.cast4mv.l0adg7@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Weber wrote:

> I'm just trying to read the source code, and I am having trouble in a 
> few areas.  For example, I am completely baffled by the number of macros 
> that get called in some places.  For example, in the semaphore code... 
> just wondering why DECLARE_MUTEX (macro) calls DECLARE_SEMAPHORE_GENERIC 
> (macro) calls SEMAPHORE_INITIALIZER (macro) calls 
> WAIT_QUEUE_HEAD_INITIALIZER (macro) and so on, and so on...

I apologize, but this was mistakenly sent to the wrong mailing list...
I was complaining about some parts of the kernel that gcc 3.1 was having 
  trouble with, which upon reading I was having trouble with :).

Sorry for the pollution...

