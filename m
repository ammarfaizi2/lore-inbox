Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269523AbUHZUD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269523AbUHZUD3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269435AbUHZTya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 15:54:30 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50660 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269530AbUHZTvl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:51:41 -0400
Date: Thu, 26 Aug 2004 21:51:33 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [2.4 patch][0/6] fix compile errors with gcc 3.4
Message-ID: <20040826195133.GB12772@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

the following six patches fix compile errors in 2.4.28-pre2 when using 
gcc 3.4 .

In my fixes, I tried to be as near at 2.6 as possible.

Please apply
Adrian
