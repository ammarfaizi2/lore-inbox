Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311433AbSDQRuX>; Wed, 17 Apr 2002 13:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311454AbSDQRuW>; Wed, 17 Apr 2002 13:50:22 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:64749 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S311433AbSDQRuU>;
	Wed, 17 Apr 2002 13:50:20 -0400
Date: Wed, 17 Apr 2002 23:22:53 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.8: preemption + SMP broken ?
Message-ID: <20020417232253.A629@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My machine (4cpu x86) hangs while booting a kernel with SMP
and preemption enabled. It hangs while executing one of
the initcalls, probably BIO since that is where the
next boot message comes from during a successful boot with SMP
(or preemption) disabled.

Has anyone tried out preemption with SMP ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
