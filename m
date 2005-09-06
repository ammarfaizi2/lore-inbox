Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVIFC1h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVIFC1h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 22:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbVIFC1h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 22:27:37 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:40623 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751266AbVIFC1g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 22:27:36 -0400
Date: Tue, 6 Sep 2005 03:27:33 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missed s/u32/pm_message_t/ in arch/ppc/syslib/ocp.c
Message-ID: <20050906022733.GU5155@ZenIV.linux.org.uk>
References: <20050906004423.GO5155@ZenIV.linux.org.uk> <20050906021535.GA5512@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050906021535.GA5512@gate.ebshome.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 07:15:35PM -0700, Eugene Surovegin wrote:
 
> Identical fix is already in -mm

Then it really should go upstream; obvious fixes like that are not
something that needs filtration...
