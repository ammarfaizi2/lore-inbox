Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbTEHU4c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 16:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262106AbTEHU4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 16:56:32 -0400
Received: from smtp0.libero.it ([193.70.192.33]:40431 "EHLO smtp0.libero.it")
	by vger.kernel.org with ESMTP id S262093AbTEHU4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 16:56:31 -0400
Date: Thu, 8 May 2003 20:12:25 +0300
To: linux-kernel@vger.kernel.org
Subject: Weird errors for loading modules 
Message-ID: <20030508171225.GA468@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Daniele Pala <dandario@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi
i recently comiled 2.5.69 kernel and all goes fine, except that i'm not able to load modules at startup. The error
it gives is like: "modprobe: ERROR module xyz doesn't exist in /proc/modules". The same error comes out when i try to
load modules as root, but all goes fine if i log in as normal user and then i issue 'sudo modprobe xyz'. That's a
strange behaviour, anyone knows what can cause it? 
I use module-init-tools 0.9.11 

Thanks,

	Daniele Pala
