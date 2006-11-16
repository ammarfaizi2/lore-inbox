Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424009AbWKPNML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424009AbWKPNML (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 08:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424015AbWKPNML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 08:12:11 -0500
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:57764 "EHLO
	aa012msr.fastwebnet.it") by vger.kernel.org with ESMTP
	id S1424009AbWKPNMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 08:12:10 -0500
Date: Thu, 16 Nov 2006 14:11:05 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: Paul Seelig <pseelig@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.18.2 kernel BUG at mm/vmscan.c:606!
Message-ID: <20061116141105.49cf0cb0@localhost>
In-Reply-To: <20061116014330.GA9041@rumbero.org>
References: <45577194.4030406@debian.org>
	<20061112210017.5b42b880@localhost>
	<20061116014330.GA9041@rumbero.org>
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.19; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2006 02:43:30 +0100
Paul Seelig <pseelig@debian.org> wrote:

> Today i fetched the newest suspend2 patches and rebooted the machine with a
> 2.6.18.2 kernel containing them. Now let's see if the problem i reported
> persists. If yes, i'll report them to Nigel Cunningham instead.

You can also do suspend without external patches... for example with

	http://suspend.sourceforge.net/

it's also packaged by Debian:

	http://packages.debian.org/testing/admin/uswsusp

:)

-- 
	Paolo Ornati
	Linux 2.6.19-rc4-g2de6c39f on x86_64
