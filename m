Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbULLWC6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbULLWC6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 17:02:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbULLWC6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 17:02:58 -0500
Received: from gw.c9x.org ([213.41.131.17]:55890 "HELO
	nerim.mx.42-networks.com") by vger.kernel.org with SMTP
	id S262148AbULLWCe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 17:02:34 -0500
Date: Sun, 12 Dec 2004 23:02:10 +0100
From: Frank Denis <lkml@pureftpd.org>
To: linux-kernel@vger.kernel.org
Subject: Is O_DIRECT + ext3 still broken on amd64?
Message-ID: <20041212220232.GA1427@c9x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  According to this post:
  
  http://archives.neohapsis.com/archives/mysql/2004-q3/1535.html
  
  At least 2.6.7 kernels were bogus on AMD64 regarding O_DIRECT with files on
an ext3 fs.

  Is this statement still true nowadays?
