Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261377AbVAXO4W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261377AbVAXO4W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 09:56:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVAXO4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 09:56:22 -0500
Received: from gate.corvil.net ([213.94.219.177]:10000 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261377AbVAXO4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 09:56:19 -0500
Message-ID: <41F50C8C.8060200@draigBrady.com>
Date: Mon, 24 Jan 2005 14:56:12 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Stromberg <strombrg@dcs.nac.uci.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Loopback mounting from a file with a partition table?
References: <pan.2005.01.22.01.45.31.457367@dcs.nac.uci.edu>
In-Reply-To: <pan.2005.01.22.01.45.31.457367@dcs.nac.uci.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Stromberg wrote:
> Has anyone tried loopback mounting individual partitions from within a
> file that contains a partition table?
> 
> When I mount -o loop the file, I seem to get the first partition in the
> file, but I don't see anything in the man page for mount that indicates a
> way of getting any other partitions from a file with a partition table.

http://lists.gnu.org/archive/html/grub-devel/2005-01/msg00077.html

-- 
Pádraig Brady - http://www.pixelbeat.org
--
