Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129709AbRCAQcS>; Thu, 1 Mar 2001 11:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129712AbRCAQcH>; Thu, 1 Mar 2001 11:32:07 -0500
Received: from zeus.kernel.org ([209.10.41.242]:46290 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129709AbRCAQcA>;
	Thu, 1 Mar 2001 11:32:00 -0500
Date: Thu, 1 Mar 2001 16:29:53 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ben LaHaise <bcrl@redhat.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Martin Rauh <martin.rauh@gmx.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Writing on raw device with software RAID 0 is slow
Message-ID: <20010301162953.R26280@redhat.com>
In-Reply-To: <20010301160201.P26280@redhat.com> <Pine.LNX.4.30.0103011106540.13184-100000@today.toronto.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0103011106540.13184-100000@today.toronto.redhat.com>; from bcrl@redhat.com on Thu, Mar 01, 2001 at 11:08:13AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 01, 2001 at 11:08:13AM -0500, Ben LaHaise wrote:
> On Thu, 1 Mar 2001, Stephen C. Tweedie wrote:
> 
> Actually, how about making it a sysctl?  That's probably the most
> reasonable approach for now since the optimal size depends on hardware.

Fine with me.

--Stephen
