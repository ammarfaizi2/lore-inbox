Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278464AbRJOW0c>; Mon, 15 Oct 2001 18:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278458AbRJOW0X>; Mon, 15 Oct 2001 18:26:23 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:62726 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S278457AbRJOW0L>; Mon, 15 Oct 2001 18:26:11 -0400
Subject: Re: Anomalous results from access(2)
To: davids@idiom.com (David S.)
Date: Mon, 15 Oct 2001 23:32:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011015151809.D372@malign.rad.washington.edu> from "David S." at Oct 15, 2001 03:18:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15tGHL-0003ch-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	files as such for either root or a non-privileged user, and all of
> 	access(2), stat(2), and 'test -x' give consistent results for root
> 	and ordinary users when the files in question live in NFS.

Should be fixed in 2.4.10-ac/2.4.12-ac
