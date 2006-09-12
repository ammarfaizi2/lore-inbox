Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWILQPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWILQPm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 12:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWILQPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 12:15:41 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:17352 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030269AbWILQPk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 12:15:40 -0400
Message-ID: <4506DD27.7080307@fr.ibm.com>
Date: Tue, 12 Sep 2006 18:15:35 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, containers@lists.osdl.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [S390] update fs3270 to use a struct pid
References: <4506B955.7080000@fr.ibm.com> <m1r6yh5dcu.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1r6yh5dcu.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Cedric Le Goater <clg@fr.ibm.com> writes:
> 
>> this patch replaces the pid_t value with a struct pid to avoid pid wrap
>> around problems.
> 
> This patch looks good here.
> Signed-off-by: Eric Biederman <ebiederm@xmission.com>

This is a patch for 2.6.18-rc6-mm2.

thanks,

C.
