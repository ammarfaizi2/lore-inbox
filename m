Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932145AbWDYIz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932145AbWDYIz6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932146AbWDYIz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:55:58 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4034 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932145AbWDYIz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:55:57 -0400
Date: Tue, 25 Apr 2006 10:55:56 +0200
From: Martin Mares <mj@ucw.cz>
To: David Schwartz <davids@webmaster.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
Message-ID: <mj+md-20060425.085309.25473.atrey@ucw.cz>
References: <mj+md-20060424.201044.18351.atrey@ucw.cz> <MDEHLPKNGKAHNMBLJOLKGEDHLIAB.davids@webmaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKGEDHLIAB.davids@webmaster.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	I don't recall anyone asking you to so much as lift a finger. Feel free to
> invest your effort where you feel it will do the most good, and try not to
> criticize others for doing the same with their own resources.

As far as they intend to stay away from the main kernel tree, I don't
critize anybody. But for example renaming otherwise logically named structure
members (`class' etc.) just for C++ compatibility _IS_ wasting time of
other people, who need to remember new names, review the patch and so on.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
If at first you don't succeed, redefine success.
