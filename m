Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311445AbSDIUhP>; Tue, 9 Apr 2002 16:37:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311454AbSDIUhO>; Tue, 9 Apr 2002 16:37:14 -0400
Received: from granite.he.net ([216.218.226.66]:36364 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id <S311445AbSDIUhN>;
	Tue, 9 Apr 2002 16:37:13 -0400
Date: Tue, 9 Apr 2002 13:37:11 -0700
From: Greg KH <greg@kroah.com>
To: Rob Hall <rob@compuplusonline.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.7,8-pre2 and USB
Message-ID: <20020409133710.A21829@kroah.com>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Rob Hall <rob@compuplusonline.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <BBENIHKKLAMLHIECFJEPAEPHCAAA.rob@compuplusonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Operating-System: Linux 2.2.20 (i686)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 09, 2002 at 02:00:31PM -0400, Rob Hall wrote:
> Hi all,
> 	I'm running a Tyan Tiger Dual Athlon motherboard(S2624). This board has an
> OHCI USB host controller on-board... I recently compiled 2.5.7, only to find
> that the machine halts as soon as the USB HC is detected. Same problem arose
> with 2.5.8-pre2.. Has the location of the USB init been changed? If I
> recompile the kernel with USB support as modules, and load the appropriate
> modules via init script, it works perfectly. Just wondering if this has been
> reported by anyone else, and if it is a known issue, what is the cause and
> is there a patch yet?

Which previous kernel did compiling the usb-ohci driver into the kernel successfully
work for you?

thanks,

greg k-h
