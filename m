Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbTFFJed (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 05:34:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbTFFJed
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 05:34:33 -0400
Received: from verein.lst.de ([212.34.189.10]:33746 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S265206AbTFFJec (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 05:34:32 -0400
Date: Fri, 6 Jun 2003 11:47:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: support@comtrol.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] License issue with rocket driver
Message-ID: <20030606094759.GA20229@lst.de>
Mail-Followup-To: Christoph Hellwig <hch>, support@comtrol.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -2.5 () USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/char/rocket{,_int}.h have an intereesting and gpl-incompatible
license.  Could you please fix it or remove the drier from the tree?
(given that mess that this driver is the latter might be the better
idea..)

The license is:

 * The following source code is subject to Comtrol Corporation's
 * Developer's License Agreement.
 * 
 * This source code is protected by United States copyright law and 
 * international copyright treaties.
 * 
 * This source code may only be used to develop software products
 * international copyright treaties.
 * 
 * This source code may only be used to develop software products that
 * will operate with Comtrol brand hardware.
 * 
 * You may not reproduce nor distribute this source code in its original
 * form but must produce a derivative work which includes portions of
 * this source code only.
 * 
 * The portions of this source code which you use in your derivative
 * work must bear Comtrol's copyright notice:
 * 
 *              Copyright 1994 Comtrol Corporation.
