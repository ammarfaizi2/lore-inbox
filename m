Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285630AbSAEVv7>; Sat, 5 Jan 2002 16:51:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286222AbSAEVvt>; Sat, 5 Jan 2002 16:51:49 -0500
Received: from [200.216.11.106] ([200.216.11.106]:40667 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id <S285630AbSAEVvl>; Sat, 5 Jan 2002 16:51:41 -0500
Date: Sat, 5 Jan 2002 19:51:47 -0200
From: =?iso-8859-1?B?RnLpZOlyaWMgTC4gVy4=?= Meunier <0@pervalidus.net>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: losetuping files in tmpfs fails?
Message-ID: <20020105215147.GH136@pervalidus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.23.1i
X-Mailer: Mutt/1.3.23.1i - Linux 2.4.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On a side note, why do I need to use losetup -d after umount
when /etc/mtab is a symlink to /proc/mounts ?

mount or loop "feature" ?

-- 
0@pervalidus.{net, {dyndns.}org} Tel: 55-21-2717-2399 (Niterói-RJ BR)
