Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbUEQRg3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUEQRg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 13:36:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbUEQRg3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 13:36:29 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:13485 "EHLO
	falcon10.austin.ibm.com") by vger.kernel.org with ESMTP
	id S262007AbUEQRgM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 13:36:12 -0400
Message-Id: <200405171735.i4HHZh8B024770@falcon10.austin.ibm.com>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.1
To: "O.Sezer" <sezero@superonline.com>
cc: marcelo.tosatti@cyclades.com, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4] decrypt/update ide help entries 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Mon, 17 May 2004 12:35:43 -0500
From: dwm@austin.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 17 May 2004 20:05:43 +0300, "O.Sezer" wrote:
...
>This has been in Alan's tree for ages, why not merge
>in mainline? Patch below, happily stolen from -ac/-pac.
>
...
>+  Promise MB Ultra 133 [PDC20275]

This controller is UDMA5 (100) max.  At least the ones I have seen.

++doug



