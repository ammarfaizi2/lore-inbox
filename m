Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288086AbSA3TSQ>; Wed, 30 Jan 2002 14:18:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287939AbSA3TSG>; Wed, 30 Jan 2002 14:18:06 -0500
Received: from ns.suse.de ([213.95.15.193]:20743 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S284902AbSA3TR7>;
	Wed, 30 Jan 2002 14:17:59 -0500
Date: Wed, 30 Jan 2002 20:17:57 +0100
From: Dave Jones <davej@suse.de>
To: =?iso-8859-1?Q?Sebastian_Dr=F6ge?= <sebastian.droege@gmx.de>
Cc: linux-kernel@vger.kernel.org, Oleg Drokin <green@namesys.com>
Subject: Re: Current Reiserfs Update / 2.5.2-dj7 Oops
Message-ID: <20020130201757.Q24012@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	=?iso-8859-1?Q?Sebastian_Dr=F6ge?= <sebastian.droege@gmx.de>,
	linux-kernel@vger.kernel.org, Oleg Drokin <green@namesys.com>
In-Reply-To: <20020130151420.40e81aef.sebastian.droege@gmx.de> <20020130173715.B2179@namesys.com> <20020130163951.13daca94.sebastian.droege@gmx.de> <20020130190905.A820@namesys.com> <20020130174011.L24012@suse.de> <20020130201054.6e150f78.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020130201054.6e150f78.sebastian.droege@gmx.de>; from sebastian.droege@gmx.de on Wed, Jan 30, 2002 at 08:10:54PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 08:10:54PM +0100, Sebastian Dröge wrote:

 > I have 3 partitions. Two reiserfs partitions, one mounted on /, one on /home

 Ok, my test box for reiserfs uses ext3 root, and reiser on a scratch disk.
 It could be Oleg's earlier guess that it may be reiser-on-root related.

 > It happens with the IDE layer version as in the dj tree and with
 > acb-io-2.5.3-p2.01212002 update (why haven't you included this in your tree,
 > Dave?)

 I never saw Andre pushing it on Linux-kernel (which is unusual for Andre 8)
 If it didn't reach my inbox, it didn't happen in my world.
 Its possible I overlooked the thread it was mentioned, or it got
 lost in noise.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
