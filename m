Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbUAVPhd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 10:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264484AbUAVPhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 10:37:32 -0500
Received: from mail018.syd.optusnet.com.au ([211.29.132.72]:11700 "EHLO
	mail018.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264451AbUAVPhc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 10:37:32 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Timothy Miller <miller@techsource.com>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: Deadline for video capture
Date: Fri, 23 Jan 2004 02:37:22 +1100
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200401221608.05924.kernel@kolivas.org> <400F5CE5.6000602@cyberone.com.au> <400FDDF8.4080600@techsource.com>
In-Reply-To: <400FDDF8.4080600@techsource.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401230237.23138.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004 01:28, Timothy Miller wrote:
> Also, what kind of other system load was going on when the capture was
> happening?  A kernel compile?  

Basically idle. With the deadline scheduler I was able to continue using the 
machine without dropping frames.

Con

