Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261245AbUKYB6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbUKYB6w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 20:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261458AbUKYB6w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 20:58:52 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:64158 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S261245AbUKYB6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 20:58:49 -0500
Message-ID: <41A4E476.8020001@am.sony.com>
Date: Wed, 24 Nov 2004 11:43:50 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ltt-dev <ltt-dev@listserv.shafik.org>
CC: celinux-dev@am.sony.com, linux kernel <linux-kernel@vger.kernel.org>
Subject: [Announce] Linux Trace Toolkit 0.9.6 now available
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a move that I hope is not too presumptuous, I have made a new release
of the Linux Trace Toolkit.  I collected some of the patches from the
ltt-dev mailing list over the last few months, and ported the existing
kernel patches to Linux version 2.6.9.  Also, I reworked small portions
of the documentation to address cross-compilation and reflect the use of
RelayFS.  I have called the release 0.9.6 (removing the 'pre' number).

Linux Trace Toolkit (LTT) is a useful, general purpose kernel event
tracing tool.  It is used by many embedded developers to help view system
behavior, including interrupt and scheduler behaviour, and kernel
interaction with process activities.

The home page for LTT is: http://www.opersys.com/LTT/

CELF maintains some information about LTT at:
   http://tree.celinuxforum.org/CelfPubWiki/LinuxTraceToolkit

The release is downloadable from the CELF patch archive at:
   http://tree.celinuxforum.org/CelfPubWiki/PatchArchive

I hope this is useful. The release has been extensively tested on a ppc
platform. There is at least one outstanding bug with flight recorder
mode, but for the most part, it appears solid. Reports of whether it
works on i386 or other platforms would be greatly appreciated.

Also, please let me know if I missed any important features or patches.


Thanks,
  -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
