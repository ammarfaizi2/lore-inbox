Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264381AbTEZNrZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 09:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264383AbTEZNrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 09:47:24 -0400
Received: from lennier.cc.vt.edu ([198.82.162.213]:64015 "EHLO
	lennier.cc.vt.edu") by vger.kernel.org with ESMTP id S264381AbTEZNrV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 09:47:21 -0400
Message-Id: <5.2.1.1.0.20030526095811.00a19df0@pop.vt.edu>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Mon, 26 May 2003 10:00:39 -0400
To: linux-kernel@vger.kernel.org
From: "John Anthony Kazos Jr." <jkazos@vt.edu>
Subject: .interp search path?
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can I configure my system to use a search path for the program 
interpreter specified in the ELF .interp section? I'm looking for the same 
behavior there is for $PATH and simple executing, so I can put something 
like "ld-linux.so" in .interp and have it find that file if it is not in 
the CWD at the time of execution.

