Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270648AbTGNNID (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 09:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270653AbTGNNHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 09:07:45 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:19123 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S270648AbTGNNHL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 09:07:11 -0400
Message-ID: <3F12AF06.6080004@free.fr>
Date: Mon, 14 Jul 2003 15:24:22 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, andrew.grover@intel.com
Cc: acpi-devel@lists.sourceforge.net
Subject: Linux 2.6-pre1 Does not boot on ASUS L3800C: lock up in acpi while
  "Executing all Devices _STA and_INIT methods" 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I happily run 2.4.21-pre5 with ACPI enabled and everything works just 
fine. I tried today 2.6-pre1 with exactly the same hardware 
configuration as the 2.4 one and the laptop does not boot. It hangs 
while dispaying : "Executing all Devices _STA and_INIT methods" 
allthough it has already printed several '.'



-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr

