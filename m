Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932581AbVJ0VMJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbVJ0VMJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:12:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbVJ0VMJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:12:09 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:35470 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932581AbVJ0VMH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:12:07 -0400
Date: Thu, 27 Oct 2005 23:11:52 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: "Fao, Sean" <sean.fao@capitalgenomix.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] kconfig and lxdialog, kernel 2.6.13.4
In-Reply-To: <4360FB36.1080404@capitalgenomix.com>
Message-ID: <Pine.LNX.4.61.0510272307050.1386@scrub.home>
References: <4360FB36.1080404@capitalgenomix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Oct 2005, Fao, Sean wrote:

> http://www2.capitalgenomix.com/temp/linux_patch/format_patch

Looks fine, but you could also please manually cleanup the parts which got 
too much indented to the right. Usually one tries to move them into 
separate functions, but sometimes exceeding the 80 char limit is IMO fine 
too.

bye, Roman
