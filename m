Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266141AbUAGIyS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 03:54:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266146AbUAGIyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 03:54:18 -0500
Received: from 90.Red-213-97-199.pooles.rima-tde.net ([213.97.199.90]:27028
	"HELO fargo") by vger.kernel.org with SMTP id S266141AbUAGIxZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 03:53:25 -0500
Date: Wed, 7 Jan 2004 09:51:25 +0100
From: David =?iso-8859-15?Q?G=F3mez?= <david@pleyades.net>
To: Sumit Narayan <sumit_uconn@lycos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Ethernet Card Intel Pro100
Message-ID: <20040107085124.GA10076@fargo>
Mail-Followup-To: Sumit Narayan <sumit_uconn@lycos.com>,
	linux-kernel@vger.kernel.org
References: <BEAEEFBEGJLPJJAA@mailcity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BEAEEFBEGJLPJJAA@mailcity.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit ;),

>  I have loaded the new kernel 2.6.0, but my Ethernet card is not working on it.
> Its Intel Ether Pro 100B. Could someone help me out with it. Its working
> perfectly fine with 2.4.21. Is there any special setting to be made for the new
> kernel? I have used module-init-tools-0.9.14 to install the modules. 

I didn't test eepro100 module, but just for the record, e100 module runs
without problems in 2.6.0...

regards,

-- 
David Gómez

"The question of whether computers can think is just like the question of
 whether submarines can swim." -- Edsger W. Dijkstra
