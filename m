Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbTICHk1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 03:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbTICHk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 03:40:26 -0400
Received: from mail5.bluewin.ch ([195.186.1.207]:33744 "EHLO mail5.bluewin.ch")
	by vger.kernel.org with ESMTP id S261539AbTICHkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 03:40:24 -0400
Date: Wed, 3 Sep 2003 09:40:13 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Danny ter Haar <dth@ncc1701.cistron.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx doesn't work
Message-ID: <20030903074013.GA13773@k3.hellgate.ch>
Mail-Followup-To: Danny ter Haar <dth@ncc1701.cistron.net>,
	linux-kernel@vger.kernel.org
References: <bj447c$el6$1@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bj447c$el6$1@news.cistron.nl>
X-Operating-System: Linux 2.6.0-test4 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Sep 2003 07:11:40 +0000, Danny ter Haar wrote:
> Subject says all! :-)
> 
> 2.6.0-test3-mm2 still works (as does 2.4.21-rc2).
> 
> vanilla 2.6.0-test4 & test4-mm[45] & the onboard ethernet doesn't seem to work.
> No kernel panics, it just doesn't work :-(

Try a kernel without ACPI and/or APIC support.

Roger
