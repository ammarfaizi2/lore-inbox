Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267843AbTCFGhF>; Thu, 6 Mar 2003 01:37:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266994AbTCFGhE>; Thu, 6 Mar 2003 01:37:04 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:11734 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266932AbTCFGhD>; Thu, 6 Mar 2003 01:37:03 -0500
Date: Wed, 5 Mar 2003 22:49:21 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.5.63/64 do not boot: loop in scsi_error
Message-ID: <20030306064921.GA1425@beaverton.ibm.com>
Mail-Followup-To: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <UTC200303060639.h266dIo22884.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200303060639.h266dIo22884.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl [Andries.Brouwer@cwi.nl] wrote:
> > See if this fixes it..
> 
> No, I am afraid not. My infinite loop does not pass through
> scsi_eh_ready_devs().
> 

Can you send me your console log. If you have scsi_logging=1 that would
be greate also.

-andmike
--
Michael Anderson
andmike@us.ibm.com

