Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261904AbTD2WwM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 18:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261916AbTD2WwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 18:52:12 -0400
Received: from gatekeeper.jupiter.com ([192.77.175.1]:18948 "EHLO
	gatekeeper.jupiter.com") by vger.kernel.org with ESMTP
	id S261904AbTD2WwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 18:52:11 -0400
Message-Id: <200304292304.h3TN47O24544@jupiter.com>
X-Mailer: exmh version 2.1.1 10/15/1999
To: linux-kernel@vger.kernel.org
Subject: Multiple Keyboards
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 29 Apr 2003 16:04:07 -0700
From: John Klingler <john@jupiter.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are there plans for the kernel to support multiple keyboard devices?
(I'm running 2.4-18SMP, which maps them all to one device.)

If not, perhaps someone can give me an idea of what I need to do.
What I want to do is get several USB keyboards to map to:
/dev/input/keyboard1, /dev/input/keyboard2, etc., the way multiple
USB mice are handled.

In case you wonder why anyone would like to do this, I want to
support multiple X servers. 

--John Klingler

