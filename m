Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281028AbRKLV7o>; Mon, 12 Nov 2001 16:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281030AbRKLV7d>; Mon, 12 Nov 2001 16:59:33 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:2300
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281028AbRKLV7S>; Mon, 12 Nov 2001 16:59:18 -0500
Date: Mon, 12 Nov 2001 13:59:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Christopher Friesen <cfriesen@nortelnetworks.com>,
        linux-kernel@vger.kernel.org
Subject: Re: how is processor cache coherency maintained for device drivers
Message-ID: <20011112135912.A32099@mikef-linux.matchmail.com>
Mail-Followup-To: James Bottomley <James.Bottomley@steeleye.com>,
	Christopher Friesen <cfriesen@nortelnetworks.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200111111655.fABGtr610172@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111111655.fABGtr610172@localhost.localdomain>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2001 at 08:55:52AM -0800, James Bottomley wrote:
> I believe (although you should take better advice from the PPC people) that 
> the powerpc is completely cache coherent, so any coherency problems you may be 
> having would be due to the hardware, not the kernel.
>

IIRC (probably wrong though) the PPC is not coherent for one of its caches,
but is for another.  PPC people would definately know the details, I'm just
thinking of a thread I read on this a few weeks ago...

Mike
