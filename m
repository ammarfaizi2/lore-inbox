Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261980AbUCOLfc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 06:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262266AbUCOLfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 06:35:32 -0500
Received: from mout0.freenet.de ([194.97.50.131]:32013 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S261980AbUCOLf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 06:35:28 -0500
From: Carsten Otte <cotte@freenet.de>
To: linux-kernel@vger.kernel.org
Subject: Re: unionfs
Date: Mon, 15 Mar 2004 12:35:25 +0100
User-Agent: KMail/1.5.4
Cc: mszeredi@inf.bme.hu, herbert@13thfloor.at
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403151235.25877.cotte@freenet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
>FWIW, have a look at http://vserver.13thfloor.at/TBVFS
I do really think this problem needs to be solved a different way: BSD-style 
union mount in VFS, no redirecting filesystem.
I am planning to work on that during the 2.7. series. I do hope I will be able 
to write code clean enough for inclusion, lets see...

