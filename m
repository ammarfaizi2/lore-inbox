Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278837AbRJVOh7>; Mon, 22 Oct 2001 10:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278836AbRJVOht>; Mon, 22 Oct 2001 10:37:49 -0400
Received: from buserror-extern.convergence.de ([212.84.236.66]:28801 "EHLO
	fefe.de") by vger.kernel.org with ESMTP id <S278839AbRJVOhe>;
	Mon, 22 Oct 2001 10:37:34 -0400
Date: Mon, 22 Oct 2001 16:37:55 +0200
From: Felix von Leitner <leitner@fefe.de>
To: linux-kernel@vger.kernel.org
Subject: BUG: "ulong" in <linux/videodev.h>
Message-ID: <20011022163755.A409@fefe.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In that header file, "ulong" is used.  It should be __u32 instead.

Felix
