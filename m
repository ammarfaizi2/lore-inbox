Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUE1R3c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUE1R3c (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 13:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUE1R3c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 13:29:32 -0400
Received: from [207.11.29.246] ([207.11.29.246]:55058 "EHLO homedepot.com")
	by vger.kernel.org with ESMTP id S263735AbUE1R3a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 13:29:30 -0400
Subject: sed problem
X-Priority: 3 (Normal)
Importance: Normal
To: linux-kernel@vger.kernel.org
Message-ID: <OF2A0BCA57.1FD871B0-ON85256EA2.005F0120@homedepot.com>
From: Kathy_Emory@HomeDepot.com
Date: Fri, 28 May 2004 13:28:42 -0400
MIME-Version: 1.0
X-MIMETrack: Serialize by Router on PROD0102/THD(Release 5.0.11  |July 24, 2002) at 05/28/2004
 01:28:43 PM,
	Itemize by SMTP Server on PRNGIS03/THD(Release 5.0.11  |July 24, 2002) at
 05/28/2004 01:28:43 PM,
	Serialize by Router on PRNGIS03/THD(Release 5.0.11  |July 24, 2002) at 05/28/2004
 01:28:43 PM,
	Serialize complete at 05/28/2004 01:28:43 PM
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

t
       s/\^/\^M/g

instead of like this:

      s/\^/\^J/g

Any ideas?

Thanks,

Kathy Emory kemory30075@yahoo.com


