Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129387AbQLFS77>; Wed, 6 Dec 2000 13:59:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129956AbQLFS7t>; Wed, 6 Dec 2000 13:59:49 -0500
Received: from zeus.kernel.org ([209.10.41.242]:38154 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129387AbQLFS7s>;
	Wed, 6 Dec 2000 13:59:48 -0500
Date: Wed, 6 Dec 2000 18:26:21 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Peng Dai <dai@mclinux.com>
Cc: linux-kernel@vger.kernel.org,
        Larry Woodman <woodman@missioncriticallinux.com>,
        David Winchell <winchell@mclinux.com>
Subject: Re: Fixing random corruption in raw IO on 2.2.x kernel with bigmem enabled
Message-ID: <20001206182621.A2101@redhat.com>
In-Reply-To: <3A2E7756.979988E8@mclinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A2E7756.979988E8@mclinux.com>; from dai@mclinux.com on Wed, Dec 06, 2000 at 12:28:54PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Dec 06, 2000 at 12:28:54PM -0500, Peng Dai wrote:
> 
> This patch fixes a subtle corruption when doing raw IO on the 2.2.x
> kernel
> with bigmem enabled. The problem was first reported by Markus Döhr while

That patch is already part of the full bugfixed raw IO patchset I
posted out a few days ago.  Look for kiobuf-2.2.18pre24-B.tar.gz in

	ftp.uk.linux.org:/pub/linux/sct/fs/raw-io
or	ftp.*.kernel.org:/pub/linux/kernel/people/sct/raw-io

Cheers,
 Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
