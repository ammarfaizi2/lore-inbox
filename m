Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261856AbTITLfq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 07:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbTITLfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 07:35:46 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:39428 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S261856AbTITLfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 07:35:45 -0400
Date: Sat, 20 Sep 2003 13:35:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Stacy Woods <stacyw@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bugs sitting in the NEW state for more than 28 days
Message-ID: <20030920113539.GB996@mars.ravnborg.org>
Mail-Followup-To: Stacy Woods <stacyw@us.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F6B19B1.7080101@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F6B19B1.7080101@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 10:58:57AM -0400, Stacy Woods wrote:
> 
> 859  Other      Other      bugme-janitors@lists.osdl.org
> make rpm overwrite previously written .config file

In the analysis this ended up being an error in gconfig.
Please close this bug.

Someone should give gconfig a good try to see if there is
any pending erros. If someone is good at GTK then there is a
lot of warnings to be cleaned up.

	Sam
