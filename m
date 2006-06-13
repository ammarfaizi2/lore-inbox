Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWFMUa5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWFMUa5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWFMUa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:30:57 -0400
Received: from p-dns.epublica.de ([213.238.59.9]:36770 "EHLO
	kermit.epublica.de") by vger.kernel.org with ESMTP id S932150AbWFMUa5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:30:57 -0400
Message-ID: <448F207A.6080601@hanno.de>
Date: Tue, 13 Jun 2006 22:30:50 +0200
From: Hanno Mueller <sockpuppet@hanno.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060522)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: more than 3 GB in userspace (4G/4G patch?) for 2.6.16
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

on my 8 GB system with two 32-bit-xeons, I would like to have more than
3 gigs in userspace.

A 0.5/3.5 GB split appears to be what I need for my application.

I read about the 4G/4G patch from 2004 but couldn't find a current patch
for 2.6.16 - is there anything similar to it that I can apply on a
2.6.16 kernel?

Thanks a lot & regards,

Hanno
