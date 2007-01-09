Return-Path: <linux-kernel-owner+w=401wt.eu-S1751294AbXAIKf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbXAIKf7 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbXAIKf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:35:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:58294 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294AbXAIKf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:35:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=XRTR0IXGFS4KzzmWSNn4CWQ5NUZ3eK/vn6sPU7x67gMllc9HlCa7+ii1D/a5YSefD/FBUAWj41zi4QL9OGI7pP3MykC4vN+3PIVps/tcpYyc32otj/CHP7cbNDl9d7KW4bgPnwPc3+VlnzTgCePu+lUYda4pN+lOUXc5si420ak=
Message-ID: <6f61137b0701090235g2ea3f4a2j2d5e985ef70b142a@mail.gmail.com>
Date: Tue, 9 Jan 2007 11:35:57 +0100
From: "Maarten Vanraes" <maarten.vanraes@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: AHCI IDENTIFY problem only on x86_64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to be CC'ed as i'm not on the list.

kernel 2.16.17.13: in 32bit the disk is detected everything ok, in
x86_64, it gives a Failed to IDENTIFY for both drives, it does not
give a FAILED to IDENTIFY on the ones where the link is down.

any idea what the problem is?

tia,
-- 
Alien is my name and head-biting is my game
