Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269706AbTGULvU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 07:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269711AbTGULvU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 07:51:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62080 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S269706AbTGULu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 07:50:57 -0400
Date: Mon, 21 Jul 2003 05:03:42 -0700
From: "David S. Miller" <davem@redhat.com>
To: chas3@users.sourceforge.net
Cc: chas@cmf.nrl.navy.mil, mikpe@csd.uu.se, linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.4.22-pre7 ATM config breakage
Message-Id: <20030721050342.7aeb48e2.davem@redhat.com>
In-Reply-To: <200307192024.h6JKOqsG028133@ginger.cmf.nrl.navy.mil>
References: <200307182330.h6INU0YJ029869@harpo.it.uu.se>
	<200307192024.h6JKOqsG028133@ginger.cmf.nrl.navy.mil>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jul 2003 16:22:21 -0400
chas williams <chas@cmf.nrl.navy.mil> wrote:

> the following changeset should take care of this once and for all:
 ...
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 03/07/19	chas@relax.cmf.nrl.navy.mil	1.1022
> # get atm config/build dependencies correct
> # --------------------------------------------

Applied, thanks Chas.
