Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbTDHWeP (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 18:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbTDHWeP (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 18:34:15 -0400
Received: from lists.asu.edu ([129.219.13.98]:24024 "EHLO lists.asu.edu")
	by vger.kernel.org with ESMTP id S262174AbTDHWeO (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 18:34:14 -0400
Date: Tue, 08 Apr 2003 15:41:50 -0700 (MST)
From: Shesha@asu.edu
Subject: readprofile: 0 total     nan
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Message-id: <Pine.GSO.4.21.0304081503130.17450-100000@general3.asu.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.4.18 kernel for ARM. I have one of the boot parameters
"profile=2". The size of the /proc/profile file is shown as 16MB. But when I
execute "readprofile" the output is ...  
0 total                                         nan

If I cat the file it just give me a ".". Can anyone suggest what i am doing
wrong?



