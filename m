Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbUK2Rpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbUK2Rpn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 12:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261440AbUK2Rpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 12:45:43 -0500
Received: from pool-141-154-235-89.bos.east.verizon.net ([141.154.235.89]:2564
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261437AbUK2Rpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 12:45:40 -0500
Message-Id: <200411292000.iATK0qOF004026@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: grendel@caudium.net
cc: linux-kernel@vger.kernel.org
Subject: Re: user- vs kernel-level resource sandbox for Linux? 
In-Reply-To: Your message of "Mon, 29 Nov 2004 11:19:19 +0100."
             <20041129101919.GB9419@beowulf.thanes.org> 
References: <20041129101919.GB9419@beowulf.thanes.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Nov 2004 15:00:52 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

grendel@caudium.net said:
>   I would appreciate any pointers to the userland solutions for that
> problem (if any exist) before I resort to Xen/UML. 

UML would be exactly what you're looking for.

				Jeff

