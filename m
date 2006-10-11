Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932130AbWJKJpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932130AbWJKJpG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 05:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbWJKJpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 05:45:06 -0400
Received: from mail.jambit.com ([62.245.207.83]:11706 "EHLO mail.jambit.com")
	by vger.kernel.org with ESMTP id S932130AbWJKJpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 05:45:04 -0400
Message-ID: <452CBE0A.9050300@gmx.net>
Date: Wed, 11 Oct 2006 11:48:58 +0200
From: Michael Kerrisk <mtk-manpages@gmx.net>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: man-pages-2.40 is released
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

I recently released man-pages-2.40.

This release is now available for download at:

    ftp://ftp.win.tue.nl/pub/linux-local/manpages

and soon at:

    ftp://ftp.kernel.org/pub/linux/docs/manpages
    or mirrors: ftp://ftp.XX.kernel.org/pub/linux/docs/manpages

Changes in this release that may be of interest to readers
of this list include the following:

Changes to individual pages
---------------------------

execve.2
    mtk
        Added list of process attributes that are not preserved on exec().

fork.2
    mtk, after a suggestion by Christoph Hellwig
        Greatly expanded, to describe all attributes that differ
        in parent and child.

linkat.2
    mtk
        Document AT_SYMLINK_FOLLOW (new in 2.6.18).

proc.5
    Chuck Ebbert
        Document /proc/PID/auxv.

Cheers,

Michael

-- 
Michael Kerrisk
maintainer of Linux man pages Sections 2, 3, 4, 5, and 7

Want to help with man page maintenance?  Grab the latest tarball at
http://www.kernel.org/pub/linux/docs/manpages/
read the HOWTOHELP file and grep the source files for 'FIXME'.
