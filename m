Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265836AbTFSQp7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 12:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265837AbTFSQp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 12:45:59 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:37265 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S265836AbTFSQp4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 12:45:56 -0400
Message-ID: <3EF1EC73.4070305@austin.ibm.com>
Date: Thu, 19 Jun 2003 12:01:39 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: ext3 umount hangs
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone else seen hangs trying to umount ext3 volumes?  I am seeing 
this repeatedly after running tiobench on an ext3 volume.  This was only 
showing up in the mm tree, but as of 2.5.72-bk2 I am now seeing it in 
the mainline.

Steve

