Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266652AbSKHQPB>; Fri, 8 Nov 2002 11:15:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266653AbSKHQPB>; Fri, 8 Nov 2002 11:15:01 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:1032 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266652AbSKHQPA>;
	Fri, 8 Nov 2002 11:15:00 -0500
Date: Fri, 8 Nov 2002 17:21:19 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: installing modules to ($PREFIX)/lib/modules/2.....
Message-ID: <20021108162119.GA959@mars.ravnborg.org>
Mail-Followup-To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20021108154132.GC1319@rdlg.net> <20021108155537.GA1027@mars.ravnborg.org> <20021108155914.GE1319@rdlg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021108155914.GE1319@rdlg.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2002 at 10:59:14AM -0500, Robert L. Harris wrote:
> 
> 
> Didn't work.  Put them in /lib/modules/2.4.18. (Didn't bite me this time
> because my server is on a different kernel but will in the near future).
My bad.
It is INSTALL_MOD_PATH.
Try that.

	Sam
