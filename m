Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264853AbRGITk4>; Mon, 9 Jul 2001 15:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264872AbRGITkq>; Mon, 9 Jul 2001 15:40:46 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:687 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264856AbRGITkh>;
	Mon, 9 Jul 2001 15:40:37 -0400
Date: Mon, 9 Jul 2001 12:39:36 -0700
From: Jonathan Lahr <lahr@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: io_request_lock patch?
Message-ID: <20010709123936.E6013@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have heard that a patch to reduce io_request_lock contention by
breaking it into per queue locks was released in the past.  Does 
anyone know where I could find this patch if it exists?

Thanks,
Jonathan

-- 
Jonathan Lahr
IBM Linux Technology Center
Beaverton, Oregon
lahr@us.ibm.com
503-578-3385

