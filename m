Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274017AbRISHRj>; Wed, 19 Sep 2001 03:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273958AbRISHRa>; Wed, 19 Sep 2001 03:17:30 -0400
Received: from tisch.mail.mindspring.net ([207.69.200.157]:9014 "EHLO
	tisch.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S273937AbRISHRU>; Wed, 19 Sep 2001 03:17:20 -0400
Subject: Re: [PATCH] (Updated) Preemptible Kernel
From: Robert Love <rml@ufl.edu>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1000858241.832.16.camel@phantasy>
In-Reply-To: <1000858241.832.16.camel@phantasy>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13.99+cvs.2001.09.18.07.08 (Preview Release)
Date: 19 Sep 2001 03:18:49 -0400
Message-Id: <1000883933.864.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-09-18 at 20:10, Robert Love wrote:
> This patch enables a preemptible kernel - now userspace programs can be
> preempted, even if in kernel land.  This should result in greater system
> response.

2.4.10-pre12-preempt patch is available at
http://tech9.net/rml/linux/patch-rml-2.4.10-pre12-preempt-kernel-1

Also, the XFS fix has been committed to CVS. So subsequent CVS dumps or
releases will not need the extra patch.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

