Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbTDHLbH (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 07:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbTDHLbH (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 07:31:07 -0400
Received: from mail.ithnet.com ([217.64.64.8]:16658 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S261832AbTDHLbG (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 07:31:06 -0400
Date: Tue, 8 Apr 2003 13:42:40 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Compiling kernel with SuSE 8.2/gcc 3.3
Message-Id: <20030408134240.45cdad7e.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

during tests with latest SuSE distro 8.2 compiling 2.4.21-pre6 showed a lot of
"comparison between signed and unsigned" warnings. It looks like SuSE ships gcc
3.3 (prerelease). Is this compiler known to work for kernel compilation? Should
therefore all these warnings be fixed?

-- 
Regards,
Stephan
