Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751332AbWCHLNh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751332AbWCHLNh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWCHLNh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:13:37 -0500
Received: from mail01.verismonetworks.com ([164.164.99.228]:22187 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751332AbWCHLNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:13:36 -0500
To: linux-kernel@vger.kernel.org
Subject: Large File support 
Date: Wed, 08 Mar 2006 16:35:28 +0530
From: "Krishna Prasanth" <krishnap@verismonetworks.com>
Organization: Verismo Networks
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <op.s53c3ew1wrt9q8@192.168.1.8>
User-Agent: Opera M2/8.51 (Linux, build 1462)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
    I would like to enable Large File support on applications running on  
linux kernel 2.4.x
    (using glibc-2.2.5).
    All i did was included the flag -D_FILE_OFFSET_BITS=64.
    I read in some documents which also specifies to include  
-D_LARGEFILE_SOURCE apart
    from the above flag.

    Please clarify me whether it is necessary to include both the flags. As  
per my
    requirement i want to 64-bit usage, replacing the older ones(32-bit).
-- 
Thanks & Regards
-Prasanth
