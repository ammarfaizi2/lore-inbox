Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265001AbTFLVaU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 17:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265002AbTFLVaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 17:30:20 -0400
Received: from 66-133-183-62.br1.fod.ia.frontiernet.net ([66.133.183.62]:12476
	"EHLO www.duskglow.com") by vger.kernel.org with ESMTP
	id S265001AbTFLVaM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 17:30:12 -0400
From: Russell Miller <rmiller@duskglow.com>
Reply-To: rmiller@duskglow.com
Organization: If you only saw my house...
To: linux-kernel@vger.kernel.org
Subject: aic79xx problem
Date: Thu, 12 Jun 2003 16:39:34 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306121639.37085.rmiller@duskglow.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I'm hoping that you can help or give me pointers as where to turn.

We just set up a dual xeon system with an integrated Adaptec Ultra320 
controller under redhat 8.0.  It seems to work ok, except upon startup, the 
driver reports that it could not negotiate WIDE, synchronous, or command 
tagging.  The last two I'm not so worried about, the first I'm a little 
puzzled about.  It is a wide drive, a wide controller, all of the jumpers are 
set up properly on the drive, the bios is set up correctly (enabling wide, 
synchronous, and I believe tagging), yet the drive refuses to go WIDE.  I 
believe this could knock performance down by half, which is unacceptable, 
considering how much we paid for a fast drive.  Are there known issues in the 
kernel or drivers that could cause this to happen?

Thanks in advance!  And please CC me on any responses.

--Russell

-- 
Randomly generated fortune cookie:
Nullum magnum ingenium sine mixtura dementiae fuit. [There is no great genius 
without some touch of madness.] -- Seneca

Russell Miller - rmiller@duskglow.com - Somewhere near Sioux City, IA.

