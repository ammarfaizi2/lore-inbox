Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751440AbWCHLRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751440AbWCHLRu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 06:17:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWCHLRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 06:17:49 -0500
Received: from mail01.verismonetworks.com ([164.164.99.228]:25003 "EHLO
	mail01.verismonetworks.com") by vger.kernel.org with ESMTP
	id S1751440AbWCHLRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 06:17:49 -0500
To: linux-kernel@vger.kernel.org
Subject: Large File size & Send file
Date: Wed, 08 Mar 2006 16:39:40 +0530
From: "Krishna Prasanth" <krishnap@verismonetworks.com>
Organization: Verismo Networks
Content-Type: text/plain; format=flowed; delsp=yes; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID: <op.s53daeq4wrt9q8@192.168.1.8>
User-Agent: Opera M2/8.51 (Linux, build 1462)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
    I would like to use sendfile & LFS enabled(included  
-D_FILE_OFFSET_BITS=64).
    I'm using glibc-2.2.5 & linux-2.4.x
    But my compiler is throughing an error saying that sendfile is not  
supported
    with -D_FILE_OFFSET_BITS=64.

    I need to support both LFS & sendfile(64).
    Pls clarify me whether i can use sendfile(64) with LFS or not.


-- 
Thanks & Regards
-Prasanth
