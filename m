Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264693AbUFGOjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264693AbUFGOjU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264702AbUFGOjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:39:20 -0400
Received: from levante.wiggy.net ([195.85.225.139]:8125 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S264693AbUFGOjR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:39:17 -0400
Date: Mon, 7 Jun 2004 16:39:16 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild make deb patch
Message-ID: <20040607143916.GN21794@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040607141353.GK21794@wiggy.net> <40C47D73.4000001@arcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C47D73.4000001@arcom.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously David Vrabel wrote:
> Why this and not the make-kpkg utility in Debian's kernel-package package?

Several reasons:

a) it works on non-Debian systems which use dpkg
b) it is a *lot* simpler and faster than make-kpkg

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
