Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261427AbUK1K4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbUK1K4u (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 05:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbUK1K4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 05:56:50 -0500
Received: from levante.wiggy.net ([195.85.225.139]:1715 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261427AbUK1K4s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 05:56:48 -0500
Date: Sun, 28 Nov 2004 11:56:46 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with ioctl command TCGETS
Message-ID: <20041128105646.GD22793@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <E1CYLpf-0001VQ-00@dorka.pomaz.szeredi.hu> <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net>
User-Agent: Mutt/1.5.6+20040722i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Bernd Eckenfels wrote:
> The syscall should also allow cunking in response, unless we remove all
> high-volumne answers from it.

Are we reinventing netlink?

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
