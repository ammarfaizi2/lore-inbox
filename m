Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268089AbUJHIOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268089AbUJHIOt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 04:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268117AbUJHIOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 04:14:49 -0400
Received: from host-212-98-231-41.borusantelekom.com ([212.98.231.41]:10449
	"HELO mail.ejder.com") by vger.kernel.org with SMTP id S268089AbUJHINR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 04:13:17 -0400
Message-ID: <41664C12.6010302@debian.org>
Date: Fri, 08 Oct 2004 11:13:06 +0300
From: Murat Demirten <murat@debian.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Keyboard input without VGA controller and serial console
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure about the question is suitable for list or not but I cannot 
find any information elsewhere.

When the CONFIG_VGA_CONSOLE is set to No or system doesn't have a VGA 
controller, is it still possible to take keyboard input? For example, 
taking input from keyboard and displaying into a connected LCD display.
(I'm using 2.4.27 and I can't take input from keyboard)

Regards,
