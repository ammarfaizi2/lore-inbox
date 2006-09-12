Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030203AbWILPMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030203AbWILPMa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 11:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030212AbWILPMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 11:12:30 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:22145 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030203AbWILPMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 11:12:30 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, containers@lists.osdl.org
Subject: Re: [S390] update fs3270 to use a struct pid
References: <4506B955.7080000@fr.ibm.com>
Date: Tue, 12 Sep 2006 09:11:29 -0600
In-Reply-To: <4506B955.7080000@fr.ibm.com> (Cedric Le Goater's message of
	"Tue, 12 Sep 2006 15:42:45 +0200")
Message-ID: <m1r6yh5dcu.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cedric Le Goater <clg@fr.ibm.com> writes:

> this patch replaces the pid_t value with a struct pid to avoid pid wrap
> around problems.

This patch looks good here.
Signed-off-by: Eric Biederman <ebiederm@xmission.com>

Eric
