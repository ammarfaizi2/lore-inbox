Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269385AbRHLQnD>; Sun, 12 Aug 2001 12:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269386AbRHLQmx>; Sun, 12 Aug 2001 12:42:53 -0400
Received: from [209.250.53.67] ([209.250.53.67]:25348 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S269385AbRHLQmj>; Sun, 12 Aug 2001 12:42:39 -0400
Date: Sun, 12 Aug 2001 11:36:07 -0500
From: Steven Walter <srwalter@yahoo.com>
To: f5ibh <f5ibh@db0bm.ampr.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nVidia Riva frame buffers and resolution selection
Message-ID: <20010812113607.A787@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	f5ibh <f5ibh@db0bm.ampr.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200108121609.SAA05624@db0bm.ampr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200108121609.SAA05624@db0bm.ampr.org>; from f5ibh@db0bm.ampr.org on Sun, Aug 12, 2001 at 06:09:20PM +0200
X-Uptime: 11:02am  up 7 min,  0 users,  load average: 1.00, 0.86, 0.43
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 12, 2001 at 06:09:20PM +0200, f5ibh wrote:
> Is there a mean to switch all the VT to the same resolution when the nVidia
> Riva frame buffer is activated.
> ------------
> Regards
> 		Jean-Luc

fbset -a <resolution>
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
