Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264507AbTFEIgS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 04:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264514AbTFEIgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 04:36:18 -0400
Received: from pf138.torun.sdi.tpnet.pl ([213.76.207.138]:22541 "EHLO centaur")
	by vger.kernel.org with ESMTP id S264507AbTFEIgR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 04:36:17 -0400
Subject: Re: [2.5.70-bk-20030603] oldconfig always asking for machine type
	(x86)
From: Witold Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0306040219250.12110-100000@serv>
References: <1054668864.12364.8.camel@samael.culm.net>
	 <Pine.LNX.4.44.0306040219250.12110-100000@serv>
Content-Type: text/plain; charset=ISO-8859-2
Organization: 
Message-Id: <1054802985.14081.0.camel@samael.culm.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2.99 (Preview Release)
Date: 05 Jun 2003 10:49:45 +0200
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

W li¶cie z ?ro, 04-06-2003, godz. 02:20, Roman Zippel pisze: 
> Hi,
> 
> On 3 Jun 2003, Witold Krecicki wrote:
> 
> > Even if I'm doing this once after another, this a lil' bit complicates
> > creating binary packages with kernel, as building it should not wait for
> > any user input/interaction.
> 
> I think I found the problem, could you try the patch below?
OK, it's working now :) 
WK

