Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262489AbTEFJjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 05:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTEFJjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 05:39:39 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34628 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S262489AbTEFJji
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 05:39:38 -0400
To: "Stephen M. Kenton" <skenton@ou.edu>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Kernel hot-swap using Kexec, BProc and CC/SMP Clusters.
References: <3EB729D3.A5BFF512@ou.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 May 2003 03:49:08 -0600
In-Reply-To: <3EB729D3.A5BFF512@ou.edu>
Message-ID: <m1y91k9zhn.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen M. Kenton" <skenton@ou.edu> writes:

> Assuming this would work, any reason it should not be doable
> on a HT uniprocessor rather than a "real" smp box?

No but currently we are a significant ways from both process
migration, and running multiple kernels on one box.

Eric
