Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280890AbRKYNem>; Sun, 25 Nov 2001 08:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280891AbRKYNeb>; Sun, 25 Nov 2001 08:34:31 -0500
Received: from ns0.ipal.net ([206.97.148.120]:2746 "HELO vega.ipal.net")
	by vger.kernel.org with SMTP id <S280890AbRKYNeQ>;
	Sun, 25 Nov 2001 08:34:16 -0500
Date: Sun, 25 Nov 2001 07:34:10 -0600
From: Phil Howard <phil-linux-kernel@ipal.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel Releases
Message-ID: <20011125073410.B26870@vega.ipal.net>
In-Reply-To: <20011125012507.C6414@osdlab.org> <12023.1006683861@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12023.1006683861@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 25, 2001 at 09:24:21PM +1100, Keith Owens wrote:

| Have you been following the kbuild 2.5 developments[1]?  Linus has
| agreed that this change will go in early in the 2.5 cycle, that will
| impact on all automated testing for 2.5.  There will be both good and
| bad impacts, the bad is the initial changeover, the good is a much
| cleaner build process and the ability to build multiple configurations
| from a single source tree.

Some of us have this ability with our own stuff already.  I've been
doing automated multi-config builds since 2.0.  But it will be nice
to not have to track a moving target anymore.  There will be a bigger
initial bump for some of us, but hopefully all the features will be
in there.

-- 
-----------------------------------------------------------------
| Phil Howard - KA9WGN |   Dallas   | http://linuxhomepage.com/ |
| phil-nospam@ipal.net | Texas, USA | http://phil.ipal.org/     |
-----------------------------------------------------------------
