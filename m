Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbTGFQVG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 12:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266683AbTGFQVG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 12:21:06 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:25873 "EHLO
	krusty.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262568AbTGFQUg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 12:20:36 -0400
Date: Sun, 6 Jul 2003 18:35:08 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre3
Message-ID: <20030706163508.GA21898@krusty.dt.e-technik.uni-dortmund.de>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.55L.0307052151180.21992@freak.distro.conectiva>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 05 Jul 2003, Marcelo Tosatti wrote:

> Here goes -pre3. It contains a lot of updates and fixes all over.

It still lacks the update of the "shortlog" (aka. lk-changelog.pl)
:-(

bk clone bk://kernel.bkbits.net/torvalds/tools/
bk get shortlog
feed your changelog through shortlog

