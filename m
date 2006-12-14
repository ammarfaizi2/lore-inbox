Return-Path: <linux-kernel-owner+w=401wt.eu-S1750978AbWLNUpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWLNUpn (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 15:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWLNUpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 15:45:43 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:57724 "EHLO
	rwcrmhc12.comcast.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750978AbWLNUpm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 15:45:42 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 15:45:42 EST
Message-ID: <4581B22C.604@soleranetworks.com>
Date: Thu, 14 Dec 2006 13:21:00 -0700
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: execv() problems with busybox on 2.6.18
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


/etc/init.d/rcS script execution fails with busybox on 2.6.18.  Seems 
ldlinux.so related.    

J
