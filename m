Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135238AbRAJRst>; Wed, 10 Jan 2001 12:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135335AbRAJRsi>; Wed, 10 Jan 2001 12:48:38 -0500
Received: from host156.207-175-42.redhat.com ([207.175.42.156]:53767 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135238AbRAJRsa>; Wed, 10 Jan 2001 12:48:30 -0500
Date: Wed, 10 Jan 2001 12:48:30 -0500
From: Bill Nottingham <notting@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0 umount problem
Message-ID: <20010110124830.G31455@devserv.devel.redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <F237SHmFF4y07520vKE000060af@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <F237SHmFF4y07520vKE000060af@hotmail.com>; from hyponephele@hotmail.com on Wed, Jan 10, 2001 at 11:03:06AM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M T (hyponephele@hotmail.com) said: 
> I'm running redhat 6.2 halt scripts and strange problem appears when 
> shutting system down with kernel-2.4.0. I get message that "/ device is 
> busy". I've updated util-linux (kill,mount,umount) according to 
> documentation without any success. I've got no problems with 2.2.18.
> Any ideas?

Are you using devfs?

Bill
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
