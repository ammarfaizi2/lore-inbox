Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTJGRTJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 13:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbTJGRTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 13:19:09 -0400
Received: from main.gmane.org ([80.91.224.249]:16613 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262540AbTJGRTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 13:19:07 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: devfs vs. udev
Date: Tue, 07 Oct 2003 19:19:04 +0200
Message-ID: <yw1xk77hx8xj.fsf@users.sourceforge.net>
References: <yw1xad8dfcjg.fsf@users.sourceforge.net> <pan.2003.10.07.13.41.23.48967@dungeon.inka.de>
 <yw1xekxpdtuq.fsf@users.sourceforge.net> <20031007142349.GX1223@rdlg.net>
 <pan.2003.10.07.16.06.52.842471@dungeon.inka.de>
 <20031007165404.GB29870@carfax.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:RqzmHdb4RbZL3xk92Aeal9HjN5o=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugo Mills <hugo-lkml@carfax.org.uk> writes:

>    Surely udev needs the ability to make more than one device node or
> symlink when a device is plugged in anyway, so I just see this as an
> issue of writing the appropriate default configuration files.

Now you say "plug in".  How does udev deal with devices that don't
correspond something that can be plugged, physically or virtually
(PCI)?  I'm thinking of things like ttys, loopback devices, etc.

-- 
Måns Rullgård
mru@users.sf.net

