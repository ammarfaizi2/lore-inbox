Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272635AbSITCKm>; Thu, 19 Sep 2002 22:10:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274209AbSITCKm>; Thu, 19 Sep 2002 22:10:42 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:23792 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S272635AbSITCKm>; Thu, 19 Sep 2002 22:10:42 -0400
Date: Thu, 19 Sep 2002 22:15:46 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020919221546.A30103@redhat.com>
References: <3D8A6EC1.1010809@redhat.com> <Pine.LNX.4.44L.0209192258010.1857-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44L.0209192258010.1857-100000@imladris.surriel.com>; from riel@conectiva.com.br on Thu, Sep 19, 2002 at 11:01:33PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 19, 2002 at 11:01:33PM -0300, Rik van Riel wrote:
> So, where did you put those 800 MB of kernel stacks needed for
> 100,000 threads ?

That's what the 4KB stack patch is for. ;-)

		-ben
