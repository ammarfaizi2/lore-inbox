Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVCXAdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVCXAdF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 19:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbVCXAdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 19:33:04 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:17052 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S262268AbVCXAdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 19:33:03 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Redirecting output
To: "shafa.hidee" <shafa.hidee@gmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 23 Mar 2005 15:21:24 +0100
References: <fa.hseagm2.1l76c0o@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DE6je-00047z-Gl@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shafa.hidee <shafa.hidee@gmail.com> wrote:

>      I have created a dummy module for learning device driver in linux. I
> want to redirect the standard output of printk to my xterm. But by default
> it is redirected to tty.

tail -f /var/log/syslog (or /var/log/messages)
