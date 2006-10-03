Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWJCLW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWJCLW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 07:22:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWJCLW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 07:22:26 -0400
Received: from smtp-out001.kontent.com ([81.88.40.215]:13017 "EHLO
	smtp-out.kontent.com") by vger.kernel.org with ESMTP
	id S1750735AbWJCLWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 07:22:25 -0400
From: Oliver Neukum <oliver@neukum.org>
To: linux-kernel@vger.kernel.org
Subject: error to be returned while suspended
Date: Tue, 3 Oct 2006 13:23:00 +0200
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610031323.00547.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

which error should a character device return if a read/write cannot be
serviced because the device is suspended? Shouldn't there be an error
code specific to that?

	Regards
		Oliver
