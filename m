Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262796AbTJJOlS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 10:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262814AbTJJOlS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 10:41:18 -0400
Received: from dodge.jordet.nu ([217.13.8.142]:64680 "EHLO dodge.hybel")
	by vger.kernel.org with ESMTP id S262796AbTJJOlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 10:41:16 -0400
Subject: Re: Call trace when rmmod'ing saa7134 and error when compiling
	static
From: Stian Jordet <liste@jordet.nu>
To: Gerd Knorr <kraxel@bytesex.org>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20031010085438.GB31877@bytesex.org>
References: <1065708534.737.2.camel@chevrolet.hybel>
	 <20031009210805.GB12266@kroah.com>
	 <1065734600.6237.0.camel@chevrolet.hybel>
	 <20031009212804.GD12618@kroah.com>
	 <1065740778.22357.0.camel@chevrolet.hybel>
	 <20031010085438.GB31877@bytesex.org>
Content-Type: text/plain
Message-Id: <1065796836.1044.0.camel@chevrolet.hybel>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 10 Oct 2003 16:40:36 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fre, 10.10.2003 kl. 10.54 skrev Gerd Knorr:
> > Gerd: I still would like to be able to compile the driver static, though
> > :)
> 
> Enable CONFIG_SOUND.  Next saa7134 update will add that dependency to Kconfig.

Ahh, thanks, sorry for the noise. I had CONFIG_SOUND as a module.

Thanks again :)

Best regards,
Stian

