Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268207AbUJJI4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268207AbUJJI4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Oct 2004 04:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268212AbUJJI4Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Oct 2004 04:56:16 -0400
Received: from host-212-98-231-41.borusantelekom.com ([212.98.231.41]:10975
	"HELO mail.ejder.com") by vger.kernel.org with SMTP id S268207AbUJJI4N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Oct 2004 04:56:13 -0400
Message-ID: <4168F8D4.9090101@debian-tr.org>
Date: Sun, 10 Oct 2004 11:54:44 +0300
From: Murat Demirten <murat@debian-tr.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Using dummy console or taking keypress event
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to use dummy console on a SBC which doesn't have a vga 
controller on it.

Is it possible to continue using dummy console if there is no vga or 
framebuffer option compiled in?

The purpose for this, reading keyboard input when pressed and easiest 
way I know doing this through terminal interface.

Or, what method I must use to reading keypress events in user space?

Regards,
