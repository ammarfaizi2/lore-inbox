Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261366AbTHaMnZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 08:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261364AbTHaMnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 08:43:25 -0400
Received: from mauve.demon.co.uk ([158.152.209.66]:10972 "EHLO
	mauve.demon.co.uk") by vger.kernel.org with ESMTP id S261366AbTHaMnZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 08:43:25 -0400
From: root@mauve.demon.co.uk
Message-Id: <200308311244.NAA19278@mauve.demon.co.uk>
Subject: USB userspace tools.
Date: Sun, 31 Aug 2003 13:44:17 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030831115903.GA2298@pasky.ji.cz> from "Petr Baudis" at Aug 31, 2003 01:59:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a tool for accessing USB devices, without actually writing
a driver? Or perhaps more accurately a driver in scriptorspace.
Perhaps something that exports a number of named pipes that correspond
to endpoints?
