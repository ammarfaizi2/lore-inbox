Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbTJFL37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 07:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261686AbTJFL37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 07:29:59 -0400
Received: from big.switch.gts.cz ([195.39.57.241]:22147 "EHLO
	big.switch.gts.cz") by vger.kernel.org with ESMTP id S261615AbTJFL36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 07:29:58 -0400
Date: Mon, 6 Oct 2003 13:28:56 +0200
From: Petr Cisar <pc@big.switch.gts.cz>
To: Erik Mouw <erik@harddisk-recovery.nl>
Subject: Re: Problems with SCSI tape in 2.6.0-test6
Message-ID: <20031006112856.GA21067@big.switch.gts.cz>
Reply-To: Petr Cisar <pc@gts.cz>
References: <20031006084319.GA7360@big.switch.gts.cz> <20031006101507.GD10529@bitwizard.nl> <20031006104003.GA17439@big.switch.gts.cz> <20031006112331.GH10529@bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006112331.GH10529@bitwizard.nl>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot, I used tar with -b 1024 and it works.

Petr
