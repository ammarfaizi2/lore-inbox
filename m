Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTJFJHO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 05:07:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263898AbTJFJGk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 05:06:40 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:24589
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263011AbTJFJFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 05:05:40 -0400
Date: Mon, 6 Oct 2003 02:05:38 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Solved! was: 71MB compressed for COMPILED(!!!) 2.6.0-test6
Message-ID: <20031006090538.GC1135@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20031006082340.GA1135@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031006082340.GA1135@matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> # Kernel hacking
> #
> CONFIG_DEBUG_INFO=y

Just change that to n.

Thanks Arjan, Nick & Bos!
