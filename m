Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946886AbWKANvG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946886AbWKANvG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 08:51:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946880AbWKANvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 08:51:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:49616 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946882AbWKANvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 08:51:01 -0500
Date: Wed, 1 Nov 2006 14:50:26 +0100
From: Stefan Seyfried <seife@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org,
       linux-pm@osdl.org, "Michael S. Tsirkin" <mst@mellanox.co.il>,
       Hugh Dickins <hugh@veritas.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Lorenz <martin@lorenz.eu.org>, Adrian Bunk <bunk@stusta.de>,
       Ernst Herzberg <earny@net4u.de>
Subject: Re: 2.6.19-rc <-> ThinkPads
Message-ID: <20061101135026.GA25751@suse.de>
References: <20061029231358.GI27968@stusta.de> <20061101030126.GE27968@stusta.de> <200610312215.44454.len.brown@intel.com> <200611010611.30445.earny@net4u.de> <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>
X-Operating-System: openSUSE 10.2 (i586) Beta2, Kernel 2.6.18.1-12-default
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2006 at 09:26:12PM -0800, Linus Torvalds wrote:
> (Or it might not. Sometimes the patch that triggers changes really doesn't 
> seem to have anything to do with anything, and it literally was just a 
> latent bug that just happened to be exposed by something that had nothing 
> to do with anything at all but perhaps timing.

Especially when "booting on AC works, but on battery it doesn't", (or the
other way round), looking at timing problems seems sane to me.
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
