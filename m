Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262356AbUFRUrk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262356AbUFRUrk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbUFRUoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:44:23 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:1136 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S262356AbUFRUoF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:44:05 -0400
Date: Fri, 18 Jun 2004 22:54:38 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] kbuild: Allow HOSTLOADLIBES_foo for single-object foo
Message-ID: <20040618205438.GB4441@mars.ravnborg.org>
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	linux-kernel@vger.kernel.org, torvalds@osdl.org
References: <20040618094300.GA29540@kiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618094300.GA29540@kiste>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 11:43:00AM +0200, Matthias Urlichs wrote:
> Self-explanatory (I hope ;-) and tested.

Looks good.
Please add description of this feature to
Documentation/kbuild/makefiles.txt
and post with a descriptive changelog in usual diff format.

	Sam
