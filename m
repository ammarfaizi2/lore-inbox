Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbVIHEOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbVIHEOG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 00:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVIHEOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 00:14:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15787 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751326AbVIHEOE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 00:14:04 -0400
Date: Wed, 7 Sep 2005 21:13:50 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <martinmaurer@gmx.at>, linux-kernel@vger.kernel.org
Subject: Re: kernel status, "Elitegroup K7S5A"
Message-Id: <20050907211350.18c07fa9.zaitcev@redhat.com>
In-Reply-To: <mailman.1125954121.30702.linux-kernel2news@redhat.com>
References: <mailman.1125954121.30702.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2005 13:55:46 -0700, Andrew Morton <akpm@osdl.org> wrote:

> Re: Elitegroup K7S5A + usb_storage problem
> [linux-usb-devel] Fw: Re: Elitegroup K7S5A + usb_storage problem

This appears to be stuck. It has to have someone with a lot of patience
to play with the device.

Martin collected me a good USB trace from Windows, but I was unable
to figure out what we do differently. The device accepts writes,
everything looks fine, but if unplugged and plugged back, it returns
old data. All commands appear basically the same.

The device, BTW, is called "Fun" and "Stick". Has nothing to do with
memory sticks, of course. Stupid DNT. Anyway, a European Linux hacker
has to get his hands on one of these before any progress can be made:
 http://www.dnt.de/index.php?dir=details&pid=53038&cat=mp3-128&m_id=mp3-128&h_curr=

-- Pete
