Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVGRFy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVGRFy7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 01:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVGRFy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 01:54:58 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:17060 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S261552AbVGRFyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 01:54:21 -0400
Subject: Re: Synaptics probe problem on Acer Travelmate 3004WTMi
From: Thomas Sailer <sailer@sailer.dynip.lugs.ch>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: dtor_core@ameritech.net, linux-input@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050713183804.GA2072@ucw.cz>
References: <1121275408.3583.35.camel@playstation2.hb9jnx.ampr.org>
	 <d120d500050713103222aa9c91@mail.gmail.com>  <20050713183804.GA2072@ucw.cz>
Content-Type: text/plain
Date: Mon, 18 Jul 2005 07:54:16 +0200
Message-Id: <1121666056.3787.1.camel@unreal>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-DCC-spamcheck-02.tornado.cablecom.ch-Metrics: smtp-08.tornado.cablecom.ch 32701; Body=4
	Fuz1=4 Fuz2=4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-13 at 20:38 +0200, Vojtech Pavlik wrote:

> Also try the usual options ("i8042.nomux=1" and "usb-handoff"). One or
> both may make the problem disappear.

usb-handoff did it, thanks a lot!

Tom


