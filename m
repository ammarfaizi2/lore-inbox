Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266682AbTGHDac (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 23:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266620AbTGHDab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 23:30:31 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50071 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S266557AbTGHDa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 23:30:28 -0400
Date: Mon, 07 Jul 2003 20:37:01 -0700 (PDT)
Message-Id: <20030707.203701.38694348.davem@redhat.com>
To: jan.dittmer@tu-harburg.de
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: pppoe, fix old protocol handler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3F02A019.3040504@tu-harburg.de>
References: <3F02A019.3040504@tu-harburg.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Current 2.5.x should not print those messages anymore,
pppoe has been converted over to not be an "old protocol"
any more.
