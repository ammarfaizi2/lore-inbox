Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129272AbQKMRKF>; Mon, 13 Nov 2000 12:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129307AbQKMRJz>; Mon, 13 Nov 2000 12:09:55 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:60425 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129272AbQKMRJo>;
	Mon, 13 Nov 2000 12:09:44 -0500
Date: Mon, 13 Nov 2000 09:09:23 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: Daniel.Deimert@intermec.com
Cc: linux-kernel@vger.kernel.org, nfs@lists.sourceforge.net, alan@redhat.com
Subject: Re: [NFS] PROBLEM: 2.2.18pre17 nfs - mount/showmount failed
Message-ID: <20001113090923.A13107@valinux.com>
In-Reply-To: <E36790918FA6D411856500508BD3B2CA1B21@eusegotmail1b.eu.intermec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E36790918FA6D411856500508BD3B2CA1B21@eusegotmail1b.eu.intermec.com>; from Daniel.Deimert@intermec.com on Mon, Nov 13, 2000 at 05:58:37AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2000 at 05:58:37AM -0800, Daniel.Deimert@intermec.com wrote:
> 
> Red Hat 6.2
> server running 2.2.18pre17 and nfs-utils 0.2

When you have a NFS problem, the best thing you can do is to check if
your nfs-utils is up to date before you report it. BTW, the current
one is 0.2.1.

-- 
H.J. Lu (hjl@valinux.com)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
