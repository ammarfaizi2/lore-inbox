Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265644AbTFNIHr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 04:07:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265645AbTFNIHr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 04:07:47 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:59832
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265644AbTFNIHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 04:07:44 -0400
Subject: Re: Microstar MS-6163 blacklist
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ryan Underwood <nemesis-lists@icequake.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030614014646.GD1010@dbz.icequake.net>
References: <20030614014646.GD1010@dbz.icequake.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1055578753.7651.3.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jun 2003 09:19:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-14 at 02:46, Ryan Underwood wrote:
> It would seem that if a closer match were performed, using the version
> number of the board (3.X in my case, likely 2.X in the case of the
> broken Pro), it would be a better idea.  Perhaps another alternative
> solution would be to only disable the IO-APIC if CONFIG_APM is defined.
> (?)

Its more likely to be about BIOS version than about the board itself

