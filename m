Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266038AbTAYBmK>; Fri, 24 Jan 2003 20:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266041AbTAYBmK>; Fri, 24 Jan 2003 20:42:10 -0500
Received: from inet-mail1.oracle.com ([148.87.2.201]:29146 "EHLO
	inet-mail1.oracle.com") by vger.kernel.org with ESMTP
	id <S266038AbTAYBmJ>; Fri, 24 Jan 2003 20:42:09 -0500
Date: Fri, 24 Jan 2003 17:51:08 -0800
From: Joel Becker <Joel.Becker@oracle.com>
To: Andries.Brouwer@cwi.nl
Cc: alan@lxorguk.ukuu.org.uk, sdake@mvista.com, dougg@torque.net,
       kurt@garloff.de, linux-kernel@vger.kernel.org
Subject: Re: 32bit dev_t
Message-ID: <20030125015108.GN20972@ca-server1.us.oracle.com>
References: <UTC200301242204.h0OM4jU09451.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200301242204.h0OM4jU09451.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2003 at 11:04:45PM +0100, Andries.Brouwer@cwi.nl wrote:
> Once or twice a year I build a kernel with 32bit or 64bit dev_t.
> Every now and then submit a few patches so that doing so
> remains easy. The last real change was the change in prototype
> of the VFS *_mknod functions.

	It's good to know that the actual changes are small, but I was
specifically wondering what the status was as far as inclusion.  If
there are issues, what are they?  Etc.

Joel

-- 

"In the arms of the angel, fly away from here,
 From this dark, cold hotel room and the endlessness that you fear.
 You are pulled from the wreckage of your silent reverie.
 In the arms of the angel, may you find some comfort here."

Joel Becker
Senior Member of Technical Staff
Oracle Corporation
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
