Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbVLaPXD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbVLaPXD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 10:23:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964989AbVLaPXC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 10:23:02 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:42215 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964987AbVLaPXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 10:23:00 -0500
Subject: Re: system keeps freezing once every 24 hours / random apps
	crashing
From: Arjan van de Ven <arjan@infradead.org>
To: Mark v Wolher <trilight@ns666.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Lee Revell <rlrevell@joe-job.com>,
       Folkert van Heusden <folkert@vanheusden.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <43B6A14E.1020703@ns666.com>
References: <43B53EAB.3070800@ns666.com>
	 <200512310027.47757.s0348365@sms.ed.ac.uk>	 <43B5D3ED.3080504@ns666.com>
	 <200512310051.03603.s0348365@sms.ed.ac.uk>	 <43B5D6D0.9050601@ns666.com>
	 <43B65DEE.906@ns666.com>
	 <9a8748490512310308g1f529495ic7eab4bd3efec9e4@mail.gmail.com>
	 <43B66E3D.2010900@ns666.com>
	 <9a8748490512310349g10d004c7i856cf3e70be5974@mail.gmail.com>
	 <43B67DB6.2070201@ns666.com>  <43B6A14E.1020703@ns666.com>
Content-Type: text/plain
Date: Sat, 31 Dec 2005 16:22:50 +0100
Message-Id: <1136042571.2901.30.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-12-31 at 16:18 +0100, Mark v Wolher wrote:
> Dec 31 16:11:35 localhost kernel: Modules linked in: nv

I think you forged this oops... there's no "nv" module for nvidia cards.



