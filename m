Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266241AbUFPLNl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266241AbUFPLNl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 07:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266242AbUFPLNl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 07:13:41 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:55940 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S266241AbUFPLNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 07:13:39 -0400
Date: Wed, 16 Jun 2004 13:13:29 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: linux-kernel@vger.kernel.org
Cc: netdev@oss.sgi.com
Subject: Re: Linux 2.6.7
Message-ID: <20040616111329.GA1571@louise.pinerecords.com>
References: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0406152253390.6392@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun-15 2004, Tue, 22:56 -0700
Linus Torvalds <torvalds@osdl.org> wrote:

> Summary of changes from v2.6.7-rc3 to v2.6.7
[snip]

2.6.7's airo.ko (unlike 2.6.6's) won't allow the user to set
ESSID via "echo myessid >/proc/driver/aironet/ethX/SSID".

Changes like this shouldn't probably be made in the middle
of a stable series.

-- 
Tomas Szepe <szepe@pinerecords.com>
