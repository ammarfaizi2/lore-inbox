Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311930AbSCTSah>; Wed, 20 Mar 2002 13:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311929AbSCTSa1>; Wed, 20 Mar 2002 13:30:27 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:10120 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S311928AbSCTSa0>; Wed, 20 Mar 2002 13:30:26 -0500
Date: Wed, 20 Mar 2002 10:29:57 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Scalability problem (kmap_lock) with -aa kernels
Message-ID: <124860000.1016648997@flay>
In-Reply-To: <122510000.1016648204@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> => average cost = 1/N + (N+F)/N = (1+F+N)/N = 1 + (1+F)/N

Actually, I think this should have read 1 + (N+F)/N = 1+ 1 + F/N = 2 +F/N
but the point is the same.

Sorry,

M.

