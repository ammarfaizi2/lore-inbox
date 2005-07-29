Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbVG2Tw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbVG2Tw6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262786AbVG2Tw5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:52:57 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:24792 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262741AbVG2TwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:52:19 -0400
Date: Fri, 29 Jul 2005 21:52:01 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: David Weinehall <tao@acc.umu.se>
cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, linux-kernel@vger.kernel.org
Subject: Re: kernel guide to space (updated)
In-Reply-To: <20050729175714.GE9841@khan.acc.umu.se>
Message-ID: <Pine.LNX.4.61.0507292151220.17105@yvahk01.tjqt.qr>
References: <20050728145353.GL11644@mellanox.co.il>
 <Pine.LNX.4.61.0507290929250.26861@yvahk01.tjqt.qr> <20050729175714.GE9841@khan.acc.umu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I'd definitely call that a joe-bug.  Adding extra space for no good
>reason is just silly; for consistency we'd have to add a space for the
>case <foo>: labels also...

No, the word "case" never starts at column 1 (counting from 1), but at least 
in column <minimalIndent>, where minimalIndent is the default indent for that 
particular piece of code.


Jan Engelhardt
-- 
