Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbTJXTBL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 15:01:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262491AbTJXTBK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 15:01:10 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:18952 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S262482AbTJXTAc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 15:00:32 -0400
Date: Fri, 24 Oct 2003 21:00:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stacy Woods <stacyw@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bugs sitting in the RESOLVED state for more than 28 days
Message-ID: <20031024190026.GD1358@mars.ravnborg.org>
Mail-Followup-To: Stacy Woods <stacyw@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F992520.1080008@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F992520.1080008@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 1234  Other      Configur   zippel@linux-m68k.org
> scripts/mkconfigs uses deprecated 'head -1' syntax

grep head scripts/mkconfigs did not give any matches.
head has dimished from the file.

	Sam
