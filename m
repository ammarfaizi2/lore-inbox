Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbUKKLLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbUKKLLU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 06:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUKKLLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 06:11:19 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:52742
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S262207AbUKKLLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 06:11:18 -0500
Message-Id: <s19348d4.015@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Thu, 11 Nov 2004 12:01:29 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: logo_shown check in fbcon_scoll
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wouldn't it seem reasonable that the logo_shown check in the SM_UP case
should similarly be done in the SM_DOWN case?

Thanks, Jan
