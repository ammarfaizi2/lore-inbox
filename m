Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVAUPX7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVAUPX7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 10:23:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbVAUPX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 10:23:59 -0500
Received: from smtp9.poczta.onet.pl ([213.180.130.49]:2521 "EHLO
	smtp9.poczta.onet.pl") by vger.kernel.org with ESMTP
	id S262387AbVAUPX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 10:23:58 -0500
Message-ID: <41F11F79.3070509@poczta.onet.pl>
Date: Fri, 21 Jan 2005 16:27:53 +0100
From: Wiktor <victorjan@poczta.onet.pl>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: AT keyboard dead on 2.6
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

my AT keyboard is dead on 2.6 series. Tests on other machines proves 
that this is my-hardware-specyfic problem (exacly the same binnary works 
on different mainboards with PS/2 keyboard and another AT keyboard). 2.4 
series works correctly. On 2.6 kernel seems to not hear what keyboard 
wants to tell him (eg. atkbd.reset preforms keyboard reset but reports 
error). Were any hadrware-handling changes made since 2.4? If so, how to 
undo them and make keyboard alive? I'm grateful for any help.

---
May the Source be with you.
Wiktor


