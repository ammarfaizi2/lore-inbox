Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265233AbUAYTtP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 14:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265238AbUAYTtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 14:49:15 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:46599 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265233AbUAYTtM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 14:49:12 -0500
Date: Sun, 25 Jan 2004 20:55:00 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Marco Rebsamen <mrebsamen@swissonline.ch>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: Troubles Compiling 2.6.1 on SuSE 9
Message-ID: <20040125195500.GB5810@mars.ravnborg.org>
Mail-Followup-To: Marco Rebsamen <mrebsamen@swissonline.ch>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <200401242137.34881.mrebsamen@swissonline.ch> <200401251427.02975.mrebsamen@swissonline.ch> <20040125153610.GA3123@mars.ravnborg.org> <200401251827.23510.mrebsamen@swissonline.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401251827.23510.mrebsamen@swissonline.ch>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I get many messages:
> modprobe: modprobe: Can't open dependencies file /lib/
> modules/2.4.21-99-default/modules.dep (no such file or dir.)

Strange, you are building a 2.6 kernel.
Did you execute this as root?

	Sam
