Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265649AbUFOOSc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265649AbUFOOSc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 10:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265650AbUFOOSb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 10:18:31 -0400
Received: from cimice4.lam.cz ([212.71.168.94]:46208 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S265649AbUFOOSb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 10:18:31 -0400
Date: Tue, 15 Jun 2004 14:18:30 +0000
From: =?iso-8859-2?Q?Karel_Kulhav=FD?= <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: concurrent acces by make menuconfig
Message-ID: <20040615141830.A6241@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Is it correct to run make menuconfig (without achanging anything,
just to study the current configuration) while a make bzImage is running
on another console when the version is 2.4.25?

And a second question, is this correct for any version of linux?

Cl<
