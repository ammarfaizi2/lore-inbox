Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWBBPXe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWBBPXe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 10:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWBBPXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 10:23:34 -0500
Received: from main.gmane.org ([80.91.229.2]:61151 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751143AbWBBPXd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 10:23:33 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: yipee <yipeeyipeeyipeeyipee@yahoo.com>
Subject: changing physical page
Date: Thu, 2 Feb 2006 15:08:46 +0000 (UTC)
Message-ID: <loom.20060202T160457-366@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 62.90.3.11 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.1) Gecko/20060124 Firefox/1.5.0.1)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On a system running without swap, can there be a case in which the
kernel decides to move (from one physical page to another)
a dynamically-allocated page owned by a user program?

Thanks,
y


