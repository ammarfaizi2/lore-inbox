Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQK3WrU>; Thu, 30 Nov 2000 17:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130467AbQK3WrL>; Thu, 30 Nov 2000 17:47:11 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:60659 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S129257AbQK3WrC>; Thu, 30 Nov 2000 17:47:02 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Arnaud Installe <a.installe@ieee.org>
Cc: linux-kernel@vger.kernel.org, ainstalle@filepool.com
Date: Thu, 30 Nov 2000 15:00:10 -0800 (PST)
Subject: Re: high load & poor interactivity on fast thread creation
In-Reply-To: <20001130081443.A8118@bach.iverlek.kotnet.org>
Message-ID: <Pine.LNX.4.21.0011301459250.17363-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try the 2.4 test kernels. I had a situation of poor performance with lots
of processes and saw a dramatic improvement with the 2.4 kernel.

David Lang

On Thu, 30 Nov 2000, Arnaud Installe wrote:

> Date: Thu, 30 Nov 2000 08:14:43 +0100
> From: Arnaud Installe <arnaud@bach.kotnet.org>
> Reply-To: Arnaud Installe <a.installe@ieee.org>
> To: linux-kernel@vger.kernel.org
> Cc: ainstalle@filepool.com
> Subject: high load & poor interactivity on fast thread creation
> 
> Hello,
> 
> When creating a lot of Java threads per second linux slows down to a
> crawl.  I don't think this happens on NT, probably because NT doesn't
> create new threads as fast as Linux does.
> 
> Is there a way (setting ?) to solve this problem ?  Rate-limit the number
> of threads created ?  The problem occurred on linux 2.2, IBM Java 1.1.8.
> 
> Thanks,
> 
> 							Arnaud
> 
> -- 
> Arnaud Installe                                             a.installe@ieee.org
> 
> Look, we trade every day out there with hustlers, deal-makers, shysters,
> con-men.  That's the way businesses get started.  That's the way this
> country was built.
> 		-- Hubert Allen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
> 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
