Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265533AbUALPA1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 10:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265568AbUALPA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 10:00:27 -0500
Received: from main.gmane.org ([80.91.224.249]:31440 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265533AbUALPAY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 10:00:24 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>
Subject: Re: 2.6.1-mm1: drivers/video/sis/sis_main.c link error
Date: Mon, 12 Jan 2004 15:32:31 +0100
Organization: Cocytus
Message-ID: <vonad1-fo.ln1@legolas.mmuehlenhoff.de>
References: <20040109014003.3d925e54.akpm@osdl.org> <20040109233714.GL1440@fs.tum.de> <3FFF79E5.5010401@winischhofer.net> <Pine.LNX.4.58.0401111502380.1825@evo.osdl.org> <400261C9.5000505@winischhofer.net>
X-Complaints-To: usenet@sea.gmane.org
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Winischhofer wrote:
> Isn't a large part of the fbcon/dev stuff in current 2.6 broken anyway? 
> Could it become worse by merging James' current changes?

Well, yes. The current version of sisfb works very well on my SIS630 notebook
and the current radeonfb works in most circumstances, while applying James'
code drops over the last months has always lead to visual corruptions of
radeonfb, that make it almost unusable.
It would be very good if the fbdev patches would be available as separate
patches.

