Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbSKCWSP>; Sun, 3 Nov 2002 17:18:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263281AbSKCWSO>; Sun, 3 Nov 2002 17:18:14 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:31128 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S263291AbSKCWSN>;
	Sun, 3 Nov 2002 17:18:13 -0500
Date: Sun, 3 Nov 2002 23:24:38 +0100
To: Dax Kelson <dax@gurulabs.com>
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021103222438.GC13560@h55p111.delphi.afb.lu.se>
References: <Pine.GSO.4.21.0211022114280.25010-100000@steklov.math.psu.edu> <Pine.LNX.4.44.0211022101090.20616-100000@mooru.gurulabs.com> <20021103053109.GA19281@codepoet.org> <1036301868.31698.160.camel@thud> <20021103054243.GA19481@codepoet.org> <1036303645.31699.180.camel@thud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1036303645.31699.180.camel@thud>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 11:07:24PM -0700, Dax Kelson wrote:
> /etc/crontab &  /etc/cron.(hourly|daily|weekly|monthly)/ & /etc/cron.d/
> /etc/logrotate.conf & /etc/logrotate.d/
> /etc/profile & /etc/profile.d/
> /etc/httpd/conf/httpd.conf & /etc/httpd/conf.d/
> /etc/xinetd.conf & /etc/xinetd.d/
> /etc/lvmtab & /etc/lvmtab.d/
> /etc/makedev.d/
> /etc/pam.d/

Or 
/usr/lib/menu/ && update-menus
/etc/modutils/ && update-modules
And there are tons of more, like generating mta-config from m4.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
