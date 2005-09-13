Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbVIMLlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbVIMLlG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 07:41:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbVIMLlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 07:41:06 -0400
Received: from smtp08.web.de ([217.72.192.226]:20135 "EHLO smtp08.web.de")
	by vger.kernel.org with ESMTP id S932612AbVIMLlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 07:41:05 -0400
From: Thomas Maguin <T.Maguin@web.de>
Reply-To: T.Maguin@web.de
To: linux-kernel@vger.kernel.org
Subject: please add this to scsi_ioctl.c Basic writing commands
User-Agent: KMail/1.8.1
MIME-Version: 1.0
Content-Disposition: inline
Date: Tue, 13 Sep 2005 13:41:13 +0200
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200509131341.15191.T.Maguin@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

safe_for_write(WRITE_LONG_2)
in the next kernel,

so that it is possible for non-root users to make a cxscan (c1, c2, cu) with 
the extended readcd.c from Alexander Noe.
http://www-user.tu-chemnitz.de/~noe/readcd/

a complete package of cdrtools with the new readcd.c or just a patch against 
cdrtools can be downloaded here:
http://de.geocities.com/linux_piewie/download/

so long
Tom
