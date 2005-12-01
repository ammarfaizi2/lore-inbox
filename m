Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbVLAM6o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbVLAM6o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 07:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVLAM6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 07:58:44 -0500
Received: from quechua.inka.de ([193.197.184.2]:11152 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932211AbVLAM6n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 07:58:43 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: loadavg always equal or above 1.00 - how to explain?
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <438EE515.1080001@wpkg.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1Eho1J-0007ds-00@calista.inka.de>
Date: Thu, 01 Dec 2005 13:58:41 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <438EE515.1080001@wpkg.org> you wrote:
> What can cause this anormal load, and how can I spot it?

Look for a process in D state, might be caused by (network)filesystem
failure or a died kernel thread..

Gruss
Bernd
