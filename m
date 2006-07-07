Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932110AbWGGOyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932110AbWGGOyq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 10:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932180AbWGGOyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 10:54:46 -0400
Received: from osa.unixfolk.com ([209.204.179.118]:62954 "EHLO
	osa.unixfolk.com") by vger.kernel.org with ESMTP id S932110AbWGGOyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 10:54:46 -0400
Date: Fri, 7 Jul 2006 07:54:44 -0700 (PDT)
From: Dave Olson <olson@unixfolk.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/25] x86_64 irq: Remove the msi assumption that irq ==
 vector
In-Reply-To: <m1ac7lwuct.fsf@ebiederm.dsl.xmission.com>
Message-ID: <Pine.LNX.4.61.0607070751460.8078@osa.unixfolk.com>
References: <Pine.LNX.4.61.0606222331090.1213@osa.unixfolk.com>
 <m1ac7lwuct.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Jul 2006, Eric W. Biederman wrote:

| Dave Olson <olson@unixfolk.com> writes:
| 
| > Eric and I had a brief side discussion, which we thought should
| > be shared with the other folks interested in this issue.
| 
| Dave.  Can you play with the patch below?
| It is against 2.6.17-mm6.
| 
| It is just about a working version of a generic ht irq patch.

I'll try to do this by Monday.

Dave Olson
olson@unixfolk.com
http://www.unixfolk.com/dave
