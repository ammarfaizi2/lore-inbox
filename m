Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbTHTWvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262309AbTHTWvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:51:31 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:41453
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S262293AbTHTWva
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:51:30 -0400
Date: Thu, 21 Aug 2003 00:51:39 +0200
From: Voluspa <lista1@comhem.se>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O17int
Message-Id: <20030821005139.6997412a.lista1@comhem.se>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm doing a backup now, basically a "cp -a" of all relevant directories
on the system, and smoothness _has_ taken a penalty by the starvation
work. Scrolling a picturefilled webpage (eg cnn.com) in Opera 6.12 jerks
with each disk write, or thereabouts. Load is ca 2.5 to 3. Doing a "dd"
from /dev/zero to a large file doesn't affect anything since it's a long
steady write.

Ah well :-)
Mats Johannesson
