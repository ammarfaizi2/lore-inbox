Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVEaVri@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVEaVri (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 17:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVEaVrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 17:47:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:40327 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261546AbVEaVp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 17:45:56 -0400
Subject: recommended format for git submissions from maintainers
From: Steve French <smfltc@us.ibm.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1117575768.5455.12.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 31 May 2005 16:42:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has the recommended format for git submissions from maintainers to
mainline been described?

Presumably something along the lines of
1) create a specially named git branch in the maintainer's kernel.org
clone of the linux-2.6 git tree
2) create a summary of the changes with the output of cg-diff -r
origin:HEAD run through some filter
3) send an email message with the above to Linus

