Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292275AbSBYViC>; Mon, 25 Feb 2002 16:38:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292313AbSBYVhx>; Mon, 25 Feb 2002 16:37:53 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:38875 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292309AbSBYVhf>; Mon, 25 Feb 2002 16:37:35 -0500
From: Badari Pulavarty <pbadari@us.ibm.com>
Message-Id: <200202252136.g1PLaWs25602@eng2.beaverton.ibm.com>
Subject: SHM_LOCK question
To: linux-kernel@vger.kernel.org
Date: Mon, 25 Feb 2002 13:36:32 -0800 (PST)
Cc: pbadari@us.ibm.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to understand how SHM_LOCK works on 2.4.17.
All I can see SHM_LOCKED set in shm_flags. I don't see how 
it is locking the pages (that are already existing or future 
pages). Can somebody explain ?

Any help is appreciated.

Thanks,
Badari
