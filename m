Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbTICQ4C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:56:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbTICQ4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:56:02 -0400
Received: from mail1.bluewin.ch ([195.186.1.74]:24200 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S264124AbTICQ4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:56:00 -0400
Date: Wed, 3 Sep 2003 18:55:48 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Matt Heler <lkml@lpbproductions.com>
Cc: Danny ter Haar <dth@ncc1701.cistron.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4(-mmX) via-rhine ethernet onboard C3 mini-itx doesn't work
Message-ID: <20030903165547.GA612@k3.hellgate.ch>
Mail-Followup-To: Matt Heler <lkml@lpbproductions.com>,
	Danny ter Haar <dth@ncc1701.cistron.net>,
	linux-kernel@vger.kernel.org
References: <bj447c$el6$1@news.cistron.nl> <200309030924.00296.lkml@lpbproductions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309030924.00296.lkml@lpbproductions.com>
X-Operating-System: Linux 2.6.0-test4 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Sep 2003 09:23:55 -0700, Matt Heler wrote:
> This is also apparent in the 2.4.22 stable kernel .. I wasn't able to get my 
> via-rhine to work at all either..  Instead of turning off acpi I just put in 
> a spare 3com card I had lying around.. Still if this is in both the 2.6 and 
> now the 2.4 kernel 's .. shouldnt someone fix it ? 

Indeed. And your detailed bug reports (as outlined earlier today by Len
Brown) are going to help with that.

Roger
