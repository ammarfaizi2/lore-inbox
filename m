Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbULQBS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbULQBS3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 20:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262717AbULQBS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 20:18:29 -0500
Received: from CPE0050fc332afc-CM00407b861c34.cpe.net.cable.rogers.com ([69.197.25.155]:27778
	"EHLO nuku.localdomain") by vger.kernel.org with ESMTP
	id S262720AbULQBSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 20:18:08 -0500
Date: Thu, 16 Dec 2004 20:20:14 -0500
From: Rashkae <rashkae@tigershaunt.com>
To: linux-kernel@vger.kernel.org
Subject: Cannot mount multi-session DVD with ide-cd, must use ide-scsi
Message-ID: <20041217012014.GA5374@tigershaunt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm that Linux Kerenl 2.6.9 still cannot mount a
multi-session DVD if the last session starts at > 2.2 GB.  The
only information on this problem I can find is here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=108827602322464&w=2

Is there a patch anywhere to address this?  it would be great if
I didn't have to use ide-scsi anymore, which imposes it's own set
of added difficulties.

Please CC replies.  Thanks much.
