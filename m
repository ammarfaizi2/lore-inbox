Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbUKLLX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbUKLLX6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 06:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbUKLLX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 06:23:58 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:28551 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S262506AbUKLLX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 06:23:57 -0500
Date: Fri, 12 Nov 2004 11:23:56 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: MODULE_PARM_DESC
Message-ID: <20041112112356.GA19304@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have discovered that (at least some) modules have MODULE_PARM_DESC
defined.

Is this intended to be displayed somehow by userspace tools (like
modprobe --show-description, but nothing like this exists)? If yes, how
can I have this written out for an arbitrary module?

Cl<
