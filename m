Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTJJIu2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 04:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTJJIu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 04:50:28 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:2252 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S262730AbTJJIuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 04:50:25 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Fri, 10 Oct 2003 10:54:38 +0200
From: Gerd Knorr <kraxel@bytesex.org>
To: Stian Jordet <liste@jordet.nu>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Call trace when rmmod'ing saa7134 and error when compiling static
Message-ID: <20031010085438.GB31877@bytesex.org>
References: <1065708534.737.2.camel@chevrolet.hybel> <20031009210805.GB12266@kroah.com> <1065734600.6237.0.camel@chevrolet.hybel> <20031009212804.GD12618@kroah.com> <1065740778.22357.0.camel@chevrolet.hybel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1065740778.22357.0.camel@chevrolet.hybel>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Gerd: I still would like to be able to compile the driver static, though
> :)

Enable CONFIG_SOUND.  Next saa7134 update will add that dependency to Kconfig.

  Gerd

-- 
You have a new virus in /var/mail/kraxel
